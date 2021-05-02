import 'package:flutter/material.dart';

import 'social-media-generic.dart';

class FacebookPostEmbedData extends SocialMediaGenericEmbedData {
  final String postUrl;

  const FacebookPostEmbedData({required this.postUrl})
      : super(canChangeSize: true, bottomMargin: 2.5);

  @override
  String get htmlScriptUrl =>
      'https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.2';

  @override
  String get htmlBody =>
      '<div id="fb-root"></div><div class="fb-post" data-href="$postUrl"></div>' +
      htmlScript;

  @override
  String get pauseVideoScript => "pauseVideo()";
  @override
  String get stopVideoScript => "stopVideo()";
}
