class TwitterEmbedData {
  final String embedHtml;
  final double bottomMargin;
  final bool canChangeSize;
  final String htmlScriptUrl;
  final bool supportMediaController;

  TwitterEmbedData({
    required this.embedHtml,
    this.bottomMargin = -10,
    this.canChangeSize = true,
    this.htmlScriptUrl = "https://platform.twitter.com/widgets.js",
    this.supportMediaController = false,
  });

  String get htmlBody => embedHtml + htmlScriptUrl;
}
