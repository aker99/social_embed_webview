class FacebookEmbedData {
  final String embedHtml;
  final double bottomMargin;
  final bool canChangeSize;
  final String htmlScriptUrl;
  final String htmlInlineStyling;
  final double? aspectRatio;
  final String pauseVideoScript;
  final String stopVideoScript;
  final bool supportMediaController;

  FacebookEmbedData({
    required this.embedHtml,
    this.bottomMargin = -10,
    this.canChangeSize = true,
    this.htmlScriptUrl =
        '''<script type="text/javascript" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.2"></script>''',
    this.htmlInlineStyling = '',
    this.aspectRatio,
    this.pauseVideoScript = "pauseVideo()",
    this.stopVideoScript = "stopVideo()",
    this.supportMediaController = false,
  });

  String get htmlBody => embedHtml;
}
