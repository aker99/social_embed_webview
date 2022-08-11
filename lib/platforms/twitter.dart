class TwitterEmbedData {
  final String embedHtml;
  final double bottomMargin;
  final bool canChangeSize;
  final String htmlScriptUrl;
  final String htmlInlineStyling;
  final double? aspectRatio;
  final bool supportMediaController;

  TwitterEmbedData({
    required this.embedHtml,
    this.bottomMargin = -10,
    this.canChangeSize = true,
    this.htmlScriptUrl =
        '''<script type="text/javascript" src="https://platform.twitter.com/widgets.js"></script>''',
    this.htmlInlineStyling = '',
    this.aspectRatio,
    this.supportMediaController = false,
  });

  String get htmlBody => embedHtml + htmlScriptUrl;
}
