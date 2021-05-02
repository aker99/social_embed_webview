import 'package:flutter/material.dart';

import 'social-media-generic.dart';

class FacebookVideoEmbedData extends SocialMediaGenericEmbedData {
  final String videoUrl;

  const FacebookVideoEmbedData({required this.videoUrl})
      : super(aspectRatio: 16 / 9);

  @override
  String get htmlScriptUrl =>
      'https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.2';

  @override
  String get htmlBody =>
      '<div id="fb-root"></div><div class="fb-video" data-href="$videoUrl"></div>' +
      htmlScript;

  @override
  String get pauseVideoScript => "pauseVideo()";
  @override
  String get stopVideoScript => "stopVideo()";
}
