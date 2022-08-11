class SocialMediaObject {
  final String embedHtml;
  final bool supportMediaController;
  final bool canChangeSize;
  final double bottomMargin;
  final double aspectRatio;
  final String htmlBody;
  final String htmlScriptUrl;
  final String pauseVideoScript;
  final String startVideoScript;
  final String htmlInlineStyling;
  final String htmlScript;

  SocialMediaObject(
    this.embedHtml,
    this.supportMediaController,
    this.canChangeSize,
    this.bottomMargin,
    this.aspectRatio,
    this.htmlBody,
    this.htmlScriptUrl,
    this.pauseVideoScript,
    this.startVideoScript,
    this.htmlInlineStyling,
    this.htmlScript,
  );
}
