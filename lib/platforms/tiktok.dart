class TiktokEmbedData {
  final String embedHtml;
  final double bottomMargin;
  final bool canChangeSize;
  final String htmlScript;
  final String htmlInlineStyling;
  final double? aspectRatio;
  final bool supportMediaController;

  TiktokEmbedData({
    required this.embedHtml,
    this.bottomMargin = -10,
    this.canChangeSize = true,
    this.htmlScript =
        """<script type="text/javascript" src="https://www.tiktok.com/embed.js"></script>""",
    this.htmlInlineStyling = '',
    this.aspectRatio,
    this.supportMediaController = false,
  });

  String get htmlBody => embedHtml + htmlScript;
}
