import 'package:flutter/material.dart';

import 'social-media-generic.dart';

class InstagramEmbedData extends SocialMediaGenericEmbedData {
  final String embedHtml;

  const InstagramEmbedData({@required this.embedHtml})
      : super(canChangeSize: false);

  @override
  String get htmlScriptUrl => 'https://www.instagram.com/embed.js';

  @override
  String get htmlBody => embedHtml + htmlScript;
}
