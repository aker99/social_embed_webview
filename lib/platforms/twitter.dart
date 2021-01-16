import 'package:flutter/material.dart';

import 'social-media-generic.dart';

class TwitterEmbedData extends SocialMediaGenericEmbedData {
  final String embedHtml;

  const TwitterEmbedData({@required this.embedHtml})
      : super(canChangeSize: true, bottomMargin: -10);

  @override
  String get htmlScriptUrl => 'https://platform.twitter.com/widgets.js';

  @override
  String get htmlBody => embedHtml + htmlScript;
}
