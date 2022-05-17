import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:mobEras/core/firestore_data_wrapper.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:pedantic/pedantic.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_player/video_player.dart';

const video_path = 'assets/videos/MobERAScurto.mp4';

class MobErasVideoIntroView extends StatefulWidget {
  @override
  _MobErasVideoIntroViewState createState() => _MobErasVideoIntroViewState();
}

class _MobErasVideoIntroViewState extends State<MobErasVideoIntroView> {
  final NavigationService _navService = locator<NavigationService>();
  VideoPlayerController _controller;

  ChewieController _chewieController;

  bool showIntroText = false;

  void checkVideo() {
    if (_controller.value.position == _controller.value.duration) {
      unawaited(UserProfileData().upsert({'showIntroVideo': false}));
      _navService.clearStackAndShow(Routes.milestoneSurveyView);
    }
  }

  @override
  void initState() {
    super.initState();
    createVideo();
  }

  void createVideo() {
    if (_controller == null) {
      _controller = VideoPlayerController.asset(video_path)
        ..addListener(checkVideo);
      _chewieController = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: false,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.blue,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightGreen,
        ),
        placeholder: Container(
          color: Colors.grey,
        ),
        autoInitialize: true,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(checkVideo);
    _controller.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      ],
    );
  }
}
