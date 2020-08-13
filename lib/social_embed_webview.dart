library social_embed_webview;

import 'package:flutter/material.dart';
import 'package:social_embed_webview/utlis.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum SocailMediaPlatforms { twitter, instagram, facebook, youtube, _default }

class SocialEmbed extends StatefulWidget {
  final String embedCode;
  final SocailMediaPlatforms type;

  const SocialEmbed(
      {Key key,
      @required this.embedCode,
      this.type = SocailMediaPlatforms._default})
      : super(key: key);

  @override
  _SocialEmbedState createState() => _SocialEmbedState();
}

class _SocialEmbedState extends State<SocialEmbed> {
  double _height = 300;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: WebView(
        initialUrl: htmlToURI(_buildCode()),
        javascriptChannels:
            <JavascriptChannel>[_getHeightJavascriptChannel(context)].toSet(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  JavascriptChannel _getHeightJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'PageHeight',
        onMessageReceived: (JavascriptMessage message) {
          _setHeight(double.parse(message.message));
        });
  }

  void _setHeight(double height) {
    print("Height: " + height.toString());
    setState(() {
      _height = height;
    });
  }

  final Map<SocailMediaPlatforms, String> _socailMediaScripts = {
    SocailMediaPlatforms.twitter:
        '<script src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>',
    SocailMediaPlatforms.instagram:
        '<script async src="//www.instagram.com/embed.js"></script>',
    SocailMediaPlatforms.youtube: '',
    SocailMediaPlatforms._default: ''
  };

  String _buildCode() {
    return '<div id="widget">${widget.embedCode}</div>' +
        script +
        _socailMediaScripts[widget.type];
  }
}

String script = r"""
 <script type="text/javascript">
	const elementHeightChangeListener = (ele,callback) => {
		let lastHeight = ele.clientHeight;
		return setInterval(() => {
			const newHeight = ele.clientHeight;
			if ( lastHeight != newHeight) {
				callback(newHeight);
				lastHeight = newHeight
			}
		},300);
	}
	
	const widget = document.getElementById('widget');
  PageHeight.postMessage(widget.clientHeight + 15);
	const interval =  elementHeightChangeListener(widget, (h) => {
	  console.log('Body height changed:', h + 15);
	  PageHeight.postMessage(h + 15);
	});
	setInterval(() => clearTimeout(interval),10000);
</script>
    """;
