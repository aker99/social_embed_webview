import 'package:flutter/material.dart';

import 'social-media-generic.dart';

class TiktokEmbedData extends SocialMediaGenericEmbedData {
  final String embedHtml;

  const TiktokEmbedData({@required this.embedHtml})
      : super(canChangeSize: true);

  @override
  String get htmlScriptUrl => 'https://www.tiktok.com/embed.js';

  @override
  String get htmlBody => embedHtml + htmlScript;
}
