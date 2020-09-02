library social_embed_webview;

import 'package:flutter/material.dart';
import 'package:social_embed_webview/utlis.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
      '<script async src="https://www.instagram.com/embed.js"></script>',
  SocailMediaPlatforms.youtube: '',
  SocailMediaPlatforms.facebook_post:
      '<script async defer src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.2"></script>',
  SocailMediaPlatforms.facebook_video:
      '<script async defer src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.2"></script>'
};

class SocialEmbed extends StatefulWidget {
  final String embedCode;
  final SocailMediaPlatforms type;
  final Color backgroundColor;

  const SocialEmbed(
      {Key key,
      @required this.embedCode,
      @required this.type,
      this.backgroundColor})
      : super(key: key);

  @override
  _SocialEmbedState createState() => _SocialEmbedState();
}

class _SocialEmbedState extends State<SocialEmbed> {
  double _height = 300;

  @override
  Widget build(BuildContext context) {
    final wv = WebView(
        initialUrl: htmlToURI(_buildCode(context)),
        javascriptChannels:
            <JavascriptChannel>[_getHeightJavascriptChannel()].toSet(),
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (navigation) {
          final url = navigation.url;
          canLaunch(url).then((can) => (can) ? launch(url) : null);
          return NavigationDecision.prevent;
        });
    if (widget.type == SocailMediaPlatforms.youtube) {
      return AspectRatio(aspectRatio: 16 / 9, child: wv);
    }
    return SizedBox(height: _height, child: wv);
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

  String _buildCode(BuildContext context) {
    return '<body style="background-color: ${colorToHtmlRGBA(getBackgroundColor(context))}"><div id="widget">${_parseData()}</div></body>' +
        script +
        _socailMediaScripts[widget.type];
  }

  String _parseData() {
    if (widget.type == SocailMediaPlatforms.facebook_post) {
      return '<div class="fb-post" data-href="${widget.embedCode}" data-show-text="true"></div>';
    } else if (widget.type == SocailMediaPlatforms.facebook_video) {
      return '<div class="fb-video" data-show-text="true" data-show-captions="true" data-href="${widget.embedCode}" data-show-text="true"></div>';
    } else if (widget.type == SocailMediaPlatforms.youtube) {
      return '<iframe src="https://www.youtube.com/embed/${widget.embedCode}" frameborder="0" allow="accelerometer;  encrypted-media; gyroscope; picture-in-picture" width=100% height=100%></iframe>';
    }
    return widget.embedCode;
  }

  Color getBackgroundColor(BuildContext context) {
    return (widget.backgroundColor == null)
        ? Theme.of(context).scaffoldBackgroundColor
        : widget.backgroundColor;
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
  PageHeight.postMessage(widget.clientHeight);
  const interval =  elementHeightChangeListener(widget, (h) => {
	  PageHeight.postMessage(h);
	});
	setInterval(() => clearTimeout(interval),10000);
</script>
    """;
