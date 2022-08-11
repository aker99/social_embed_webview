import 'social-media-generic.dart';

class YoutubeEmbedData extends SocialMediaGenericEmbedData {
  final String videoId;

  const YoutubeEmbedData({required this.videoId})
      : super(supportMediaController: true, aspectRatio: 16 / 9);

  @override
  String get htmlScriptUrl => 'https://www.youtube.com/iframe_api';

  @override
  String get htmlBody =>
      """
    <div id="player" style="position: fixed; bottom: 0px;"></div>
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
  """ +
      htmlScript;

  @override
  String get pauseVideoScript => "pauseVideo()";
  @override
  String get stopVideoScript => "stopVideo()";
}
