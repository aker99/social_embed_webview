import 'package:flutter/material.dart';

import 'social-media-generic.dart';

class Youtube extends SocialMediaGeneric {
  final String videoId;

  static const String scriptUrl = 'https://www.youtube.com/iframe_api';
  static String _script;
  static String get script => (_script != null)
      ? _script
      : _script = SocialMediaGeneric.scriptGenrator(scriptUrl);

  const Youtube({@required this.videoId}) : super(16 / 9);

  @override
  String get getHtml => """
    <div id="player"></div>
    ${SocialMediaGeneric.scriptGenrator(scriptUrl)}
    <script>
      let player;
      function onYouTubeIframeAPIReady() {
        player = new YT.Player('player', {
          height: '100%',
          width: '100%',
          videoId: '$videoId',
          playerVars: {
          }
        });
      }

      function stopVideo() {
        player.stopVideo();
      }

      function pauseVideo() {
        player.pauseVideo();
      }
    </script>
  """;

  @override
  String get pauseVideoScript => "pauseVideo()";
  @override
  String get stopVideoScript => "stopVideo()";
}
