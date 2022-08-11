class FacebookEmbedData {
  final String embedHtml;
  final double bottomMargin;
  final bool canChangeSize;
  final String htmlScriptUrl;
  final String pauseVideoScript;
  final String stopVideoScript;
  final bool supportMediaController = false;

  FacebookEmbedData({
    required this.embedHtml,
    this.bottomMargin = -10,
    this.canChangeSize = true,
    this.htmlScriptUrl =
        "https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.2",
    this.pauseVideoScript = "pauseVideo()",
    this.stopVideoScript = "stopVideo()",
  });
}
