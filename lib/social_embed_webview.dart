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
  @override
  void initState() {
    super.initState();
    smObj = widget.socialMediaObj;
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
    final html = buildHTMLBody(context);
    final wv = WebView(
        initialUrl: htmlToURI(html),
        javascriptChannels:
            <JavascriptChannel>[_getHeightJavascriptChannel()].toSet(),
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (wbc) {
          wbController = wbc;
          // wbController.evaluateJavascript(smObj.htmlScript);
        },
        onPageFinished: (str) =>
            wbController.evaluateJavascript('sendHeight()'),
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
    // if (this.mounted) {
    setState(() {
      _height = height + 17;
    });
    // }
  }

  Color getBackgroundColor(BuildContext context) {
    final color = widget.backgroundColor;
    return (color == null) ? Theme.of(context).scaffoldBackgroundColor : color;
  }

  String buildHTMLBody(BuildContext context) {
    return """
      <body style="background-color: ${colorToHtmlRGBA(getBackgroundColor(context))}">
        <div id="widget">${smObj.htmlBody}</div>
        <script type="text/javascript">
          const widget = document.getElementById('widget');
          const sendHeight = () => PageHeight.postMessage(widget.clientHeight);
          ${(smObj.canChangeSize) ? dynamicHeightScript : ''}
        </script>
      </body>
    """;
  }

  static const String dynamicHeightScript = """
    <script type="text/javascript">
      const onWidgetResize = (widgets) => sendHeight();
      const resize_ob = new ResizeObserver(onWidgetResize);
      resize_ob.observe(widget);
    </script>
  """;
}

// import 'package:flutter/material.dart';
// import 'package:social_embed_webview/utils/common-utils.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
// export 'package:social_embed_webview/widgets/custom-webview.dart';

// enum SocailMediaPlatforms {
//   twitter,
//   instagram,
//   facebook_post,
//   facebook_video,
//   youtube
// }

// final Map<SocailMediaPlatforms, String> _socailMediaScripts = {
//   SocailMediaPlatforms.twitter:
//       '<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>',
//   SocailMediaPlatforms.instagram:
//       '<script async src="https://www.instagram.com/embed.js"></script>',
//   SocailMediaPlatforms.youtube: '',
//   SocailMediaPlatforms.facebook_post:
//       '<script async defer src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.2"></script>',
//   SocailMediaPlatforms.facebook_video:
//       '<script async defer src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.2"></script>'
// };

// class SocialEmbed extends StatefulWidget {
//   final String embedCode;
//   final SocailMediaPlatforms type;
//   final Color backgroundColor;

//   const SocialEmbed(
//       {Key key,
//       @required this.embedCode,
//       @required this.type,
//       this.backgroundColor})
//       : super(key: key);

//   @override
//   _SocialEmbedState createState() => _SocialEmbedState();
// }

// class _SocialEmbedState extends State<SocialEmbed> {
//   double _height = 300;

//   @override
//   Widget build(BuildContext context) {
//     final wv = WebView(
//         initialUrl: htmlToURI(_buildCode(context)),
//         javascriptChannels:
//             <JavascriptChannel>[_getHeightJavascriptChannel()].toSet(),
//         javascriptMode: JavascriptMode.unrestricted,
//         navigationDelegate: (navigation) {
//           final url = navigation.url;
//           canLaunch(url).then((can) => (can) ? launch(url) : null);
//           return NavigationDecision.prevent;
//         });
//     if (widget.type == SocailMediaPlatforms.youtube) {
//       return AspectRatio(aspectRatio: 16 / 9, child: wv);
//     }
//     return SizedBox(height: _height, child: wv);
//   }

//   JavascriptChannel _getHeightJavascriptChannel() {
//     return JavascriptChannel(
//         name: 'PageHeight',
//         onMessageReceived: (JavascriptMessage message) {
//           _setHeight(double.parse(message.message));
//         });
//   }

//   void _setHeight(double height) {
//     if (this.mounted) {
//       setState(() {
//         _height = height + 17;
//       });
//     }
//   }

//   String _parseData() {
//     if (widget.type == SocailMediaPlatforms.facebook_post) {
//       return '<div class="fb-post" data-href="${widget.embedCode}" data-show-text="true"></div>';
//     } else if (widget.type == SocailMediaPlatforms.facebook_video) {
//       return '<div class="fb-video" data-show-text="true" data-show-captions="true" data-href="${widget.embedCode}" data-show-text="true"></div>';
//     } else if (widget.type == SocailMediaPlatforms.youtube) {
//       return '';
//     }
//     return widget.embedCode;
//   }

//   Color getBackgroundColor(BuildContext context) {
//     return (widget.backgroundColor == null)
//         ? Theme.of(context).scaffoldBackgroundColor
//         : widget.backgroundColor;
//   }
// }

// String script = r"""
//   <script type="text/javascript">
//     const onWidgetResize = (widgets) => {
//       const rect = widgets[0].contentRect;
//       let height = rect.height;
//       PageHeight.postMessage(height);
//       console.log({height});
//     }
//     const resize_ob = new ResizeObserver(onWidgetResize);
//     const widget = document.getElementById('widget');
//     resize_ob.observe(widget);
//   </script>
// """;
