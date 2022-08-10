import 'social-media-generic.dart';

class FacebookVideoEmbedData extends SocialMediaGenericEmbedData {
  final String embedHtml;

  const FacebookVideoEmbedData({required this.embedHtml})
      : super(canChangeSize: true, bottomMargin: -10);

  @override
  String get htmlScriptUrl =>
      'https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.2';

  @override
  String get htmlBody => embedHtml;

  @override
  String get pauseVideoScript => "pauseVideo()";
  @override
  String get stopVideoScript => "stopVideo()";
}
