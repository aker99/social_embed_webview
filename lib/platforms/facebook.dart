import 'social-media-generic.dart';

class FacebookEmbedData extends SocialMediaGenericEmbedData {
  final String embedHtml;

  const FacebookEmbedData({required this.embedHtml})
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
