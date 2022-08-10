import 'package:social_embed_webview/platforms/social-media-generic.dart';

class TiktokEmbedData extends SocialMediaGenericEmbedData {
  final String embedHtml;

  const TiktokEmbedData({required this.embedHtml})
      : super(canChangeSize: true, bottomMargin: -10);

  @override
  String get htmlScriptUrl => 'https://www.tiktok.com/embed.js';

  @override
  String get htmlBody => embedHtml + htmlScript;
}
