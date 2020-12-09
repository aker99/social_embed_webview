abstract class SocialMediaGeneric {
  const SocialMediaGeneric(this.aspectRatio);

  final double aspectRatio;

  String get getHtml;
  String get pauseVideoScript;
  String get stopVideoScript;

  static String embedElementId = 'widget';

  static String scriptGenrator(scriptUrl) =>
      '<script type="text/javascript" src="$scriptUrl"></script>';
}
