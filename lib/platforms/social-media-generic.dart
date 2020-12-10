abstract class SocialMediaGenericEmbedData {
  const SocialMediaGenericEmbedData({
    this.canChangeSize = false,
    this.aspectRatio,
  }) : assert(!(canChangeSize == true && aspectRatio != null));
  // static final AssetsCache _assetsCache = AssetsCache();
  final double aspectRatio;
  final bool canChangeSize;

  String get htmlBody;
  String get htmlScriptUrl;
  String get pauseVideoScript => '';
  String get startVideoScript => '';
  String get stopVideoScript => '';

  String get htmlScript => """
    <script type="text/javascript" src="$htmlScriptUrl"></script>
  """;
}
