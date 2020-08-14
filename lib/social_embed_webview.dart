library social_embed_webview;

import 'package:flutter/material.dart';
import 'package:social_embed_webview/utlis.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum SocailMediaPlatforms {
  twitter,
  instagram,
  facebook_post,
  facebook_video,
  youtube
}

final Map<SocailMediaPlatforms, String> _socailMediaScripts = {
  SocailMediaPlatforms.twitter:
      '<script src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>',
  SocailMediaPlatforms.instagram:
      '<script async src="//www.instagram.com/embed.js"></script>',
  SocailMediaPlatforms.youtube: '',
  SocailMediaPlatforms.facebook_post:
      '<script async defer src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.2"></script>',
  SocailMediaPlatforms.facebook_video:
      '<script async defer src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.2"></script>'
};

class SocialEmbed extends StatefulWidget {
  final String embedCode;
  final SocailMediaPlatforms type;

  const SocialEmbed({Key key, @required this.embedCode, @required this.type})
      : super(key: key);

  @override
  _SocialEmbedState createState() => _SocialEmbedState();
}

class _SocialEmbedState extends State<SocialEmbed> {
  double _height = 300;
  @override
  Widget build(BuildContext context) {
    return _buildWebView(context);
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

  Widget _buildWebView(BuildContext context) {
    var wv = WebView(
      initialUrl: htmlToURI(_buildCode(context)),
      javascriptChannels:
          <JavascriptChannel>[_getHeightJavascriptChannel(context)].toSet(),
      javascriptMode: JavascriptMode.unrestricted,
    );
    if (widget.type == SocailMediaPlatforms.youtube) {
      return AspectRatio(aspectRatio: 16 / 9, child: wv);
    }
    return SizedBox(
      height: _height,
      child: wv,
    );
  }

  String _buildCode(BuildContext context) {
    return '<div id="widget">${_parseData(context)}</div>' +
        script +
        _socailMediaScripts[widget.type];
  }

  String _parseData(BuildContext context) {
    if (widget.type == SocailMediaPlatforms.facebook_post) {
      return '<div class="fb-post" data-href="${widget.embedCode}" data-show-text="true"></div>';
    } else if (widget.type == SocailMediaPlatforms.facebook_video) {
      return '<div class="fb-video" data-show-text="true" data-show-captions="true" data-href="${widget.embedCode}" data-show-text="true"></div>';
    } else if (widget.type == SocailMediaPlatforms.youtube) {
      return '<iframe src="https://www.youtube.com/embed/${widget.embedCode}" frameborder="0" allow="accelerometer;  encrypted-media; gyroscope; picture-in-picture" width=100% height=100%></iframe>';
    }
    return widget.embedCode;
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
