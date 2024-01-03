import 'package:acadmiat/Theme/style.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';

BetterPlayerConfiguration configurationBetterPlayer({required BuildContext context, int? startFrom}){

  return
  BetterPlayerConfiguration(
      controlsConfiguration: BetterPlayerControlsConfiguration(
        controlBarColor: Colors.black26,

        iconsColor: Colors.white,
        playIcon: Icons.play_arrow_outlined,
        progressBarPlayedColor: Theme.of(context).primaryColor,
        progressBarHandleColor:  Theme.of(context).primaryColor,
        skipBackIcon: Icons.replay_10_outlined,
        skipForwardIcon: Icons.forward_10_outlined,
        backwardSkipTimeInMilliseconds: 10000,
        forwardSkipTimeInMilliseconds: 10000,
        enableSkips: true,
        enableFullscreen: true,
        enablePip: true,
        enablePlayPause: true,
        enableMute: true,
        enableAudioTracks: true,
        enableProgressText: true,
        enableSubtitles: true,
        showControlsOnInitialize: true,
        enablePlaybackSpeed: true,
        controlBarHeight: 40,
        loadingColor: Colors.red,
        overflowModalColor:Theme.of(context).scaffoldBackgroundColor,
        overflowModalTextColor:Theme.of(context).canvasColor,// Colors.white,
        overflowMenuIconsColor: iconsColor,
      ),

      ///Orientation on full screen but only for start
      deviceOrientationsOnFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],

      ///Orientation after full screen dismissed
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],

      startAt: Duration(seconds: (startFrom != null) ? startFrom : 0),
      aspectRatio: 16 / 9,
      subtitlesConfiguration: const BetterPlayerSubtitlesConfiguration(
        fontSize: 16.0,
      ));
}


