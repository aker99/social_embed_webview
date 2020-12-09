import 'package:flutter/material.dart';
import 'package:social_embed_webview/platforms/social-media-generic.dart';
import 'package:social_embed_webview/utils/common-utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {
  final SocialMediaGeneric socialMediaObj;
  final Color backgroundColor;
  const CustomWebView(
      {Key key, @required this.socialMediaObj, this.backgroundColor})
      : super(key: key);

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView>
    with WidgetsBindingObserver {
  double _height = 300;
  String htmlBody;
  WebViewController wbController;

  @override
  void initState() {
    super.initState();
    htmlBody = buildHTMLBody(context);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        wbController.evaluateJavascript(widget.socialMediaObj.pauseVideoScript);
        break;
      case AppLifecycleState.resumed:
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
      onWebViewCreated: (wbc) => wbController = wbc,
    );
    final ar = widget.socialMediaObj.aspectRatio;
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
    if (this.mounted) {
      setState(() {
        _height = height + 17;
      });
    }
  }

  Color getBackgroundColor(BuildContext context) {
    // final color = widget.backgroundColor;
    // return (color == null) ? Theme.of(context).scaffoldBackgroundColor : color;
    return Colors.white;
  }

  String buildHTMLBody(BuildContext context) {
    return """
      <body style="background-color: ${colorToHtmlRGBA(getBackgroundColor(context))}">
        <div id="widget">${widget.socialMediaObj.getHtml}</div>
        $dynamicHeightScript
      </body>
    """;
  }

  static const String dynamicHeightScript = """
    <script type="text/javascript">
      const onWidgetResize = (widgets) => {
        const rect = widgets[0].contentRect;
        let height = rect.height;
        PageHeight.postMessage(height);
      }
      const resize_ob = new ResizeObserver(onWidgetResize);
      const widget = document.getElementById('widget');
      resize_ob.observe(widget);
    </script>
  """;
}
