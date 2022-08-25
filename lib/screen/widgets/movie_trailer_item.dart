import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/domain/model/movie_trailers_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviesTrailerItem extends StatefulWidget {
  const MoviesTrailerItem(this._trailer, {Key? key}) : super(key: key);
  final TrailerResults _trailer;

  @override
  State<MoviesTrailerItem> createState() => _MoviesTrailerItemState();
}

class _MoviesTrailerItemState extends State<MoviesTrailerItem> {
  late YoutubePlayerController _playerController;
  bool _isPlayerReady = false;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  @override
  void initState() {
    _playerController = YoutubePlayerController(
      initialVideoId: widget._trailer.key!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        showLiveFullscreenButton: true,
        controlsVisibleAtStart: true,
      ),
    )..addListener(listener);
    super.initState();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_playerController.value.isFullScreen) {
      setState(() {
        _playerState = _playerController.value.playerState;
        _videoMetaData = _playerController.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _playerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.red),
      child: Column(
        children: [
          YoutubePlayerBuilder(
            onExitFullScreen: () {
              SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp],
              );
            },
            onEnterFullScreen: () {
              SystemChrome.setPreferredOrientations(
                [DeviceOrientation.landscapeLeft],
              );
            },
            player: YoutubePlayer(
              controller: _playerController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              topActions: [
                Expanded(
                  child: Text(
                    _playerController.metadata.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.copy,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  onPressed: () {
                    _showSnackBar('Video link has been coped');
                  },
                ),
              ],
              onReady: () {
                _isPlayerReady = true;
              },
              onEnded: (data) {
                _playerController.pause();
                _showSnackBar('Video have ended');
              },
            ),
            builder: (context, player) {
              return Container(
                child: player,
              );
            },
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
