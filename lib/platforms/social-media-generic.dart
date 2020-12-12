abstract class SocialMediaGenericEmbedData {
  const SocialMediaGenericEmbedData({
    this.supportMediaControll = false,
    this.canChangeSize = false,
    this.bottomMargin = 0,
    this.aspectRatio,
  })  : assert(!(canChangeSize == true && aspectRatio != null)),
        assert(!(aspectRatio != null && bottomMargin != 0));
  // static final AssetsCache _assetsCache = AssetsCache();
  final double aspectRatio;
  final bool canChangeSize;
  final bool supportMediaControll;
  final double bottomMargin;
  String get htmlBody;
  String get htmlScriptUrl;
  String get pauseVideoScript => '';
  String get startVideoScript => '';
  String get stopVideoScript => '';

  String get htmlScript => """
    <script type="text/javascript" src="$htmlScriptUrl"></script>
  """;
}
