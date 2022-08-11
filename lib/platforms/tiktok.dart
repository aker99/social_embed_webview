class TiktokEmbedData {
  final String embedHtml;
  final double bottomMargin;
  final bool canChangeSize;
  final String htmlScriptUrl;
  final bool supportMediaController;

  TiktokEmbedData({
    required this.embedHtml,
    this.bottomMargin = -10,
    this.canChangeSize = true,
    this.htmlScriptUrl = "https://www.tiktok.com/embed.js",
    this.supportMediaController = false,
  });

  String get htmlBody => embedHtml + htmlScriptUrl;
}
