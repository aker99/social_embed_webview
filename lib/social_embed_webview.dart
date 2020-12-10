library social_embed_webview;

import 'package:flutter/material.dart';
import 'package:social_embed_webview/platforms/social-media-generic.dart';
import 'package:social_embed_webview/utils/common-utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SocialEmbed extends StatefulWidget {
  final SocialMediaGenericEmbedData socialMediaObj;
  final Color backgroundColor;
  const SocialEmbed(
      {Key key, @required this.socialMediaObj, this.backgroundColor})
      : super(key: key);

  @override
  _SocialEmbedState createState() => _SocialEmbedState();
}

class _SocialEmbedState extends State<SocialEmbed> with WidgetsBindingObserver {
  double _height = 300;
  WebViewController wbController;
  SocialMediaGenericEmbedData smObj;
  String htmlBody;

  @override
  void initState() {
    super.initState();
    smObj = widget.socialMediaObj;
    htmlBody = getHtmlBody();
    if (smObj.supportMediaControll) WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (smObj.supportMediaControll) super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.detached:
        wbController.evaluateJavascript(smObj.stopVideoScript);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        wbController.evaluateJavascript(smObj.pauseVideoScript);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final wv = WebView(
        initialUrl: htmlToURI(htmlBody),
        javascriptChannels:
            <JavascriptChannel>[_getHeightJavascriptChannel()].toSet(),
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (url) {
          final color = colorToHtmlRGBA(getBackgroundColor(context));
          wbController.evaluateJavascript(
              'document.body.style= "background-color: $color"');
        },
        onWebViewCreated: (wbc) {
          wbController = wbc;
        },
        onPageFinished: (str) {
          if (smObj.aspectRatio == null)
            wbController.evaluateJavascript('sendHeight()');
        },
        navigationDelegate: (navigation) async {
          final url = navigation.url;
          if (await canLaunch(url)) {
            launch(url);
          }
          return NavigationDecision.prevent;
        });
    final ar = smObj.aspectRatio;
    return (ar != null)
        ? AspectRatio(aspectRatio: ar, child: wv)
        : SizedBox(height: _height, child: wv);
  }

  JavascriptChannel _getHeightJavascriptChannel() {
    return JavascriptChannel(
        name: 'PageHeight',
        onMessageReceived: (JavascriptMessage message) {
          _setHeight(double.parse(message.message));
        });
  }

  void _setHeight(double height) {
    setState(() {
      _height = height + 17;
    });
  }

  Color getBackgroundColor(BuildContext context) {
    final color = widget.backgroundColor;
    return (color == null) ? Theme.of(context).scaffoldBackgroundColor : color;
  }

  String getHtmlBody() => """
      <body>
        <div id="widget">${smObj.htmlBody}</div>
        ${(smObj.aspectRatio == null) ? dynamicHeightScriptSetup : ''}
        ${(smObj.canChangeSize) ? dynamicHeightScriptCheck : ''}
      </body>
    """;

  static const String dynamicHeightScriptSetup = """
    <script type="text/javascript">
      const widget = document.getElementById('widget');
      const sendHeight = () => PageHeight.postMessage(widget.clientHeight);
    </script>
  """;

  static const String dynamicHeightScriptCheck = """
    <script type="text/javascript">
      const onWidgetResize = (widgets) => sendHeight();
      const resize_ob = new ResizeObserver(onWidgetResize);
      resize_ob.observe(widget);
    </script>
  """;
}
