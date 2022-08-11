class InstagramEmbedData {
  final String embedHtml;
  final double bottomMargin;
  final bool canChangeSize;
  final String htmlScriptUrl;
  final bool supportMediaController = false;

  InstagramEmbedData({
    required this.embedHtml,
    this.bottomMargin = -10,
    this.canChangeSize = true,
    this.htmlScriptUrl = "https://www.instagram.com/embed.js",
  });

  String get htmlBody => embedHtml + htmlScriptUrl;
}
