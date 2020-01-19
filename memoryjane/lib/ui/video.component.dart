import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoComponent extends StatefulWidget {

  final String uri;

  VideoComponent(this.uri);

  @override
  _VideoComponentState createState() => _VideoComponentState();
}

class _VideoComponentState extends State<VideoComponent> {

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.uri.startsWith("http")) {
      _controller = VideoPlayerController.network(widget.uri);
    }
    else {
      _controller = VideoPlayerController.file(File.fromUri(Uri.file(widget.uri)));
    }
    _controller.initialize().then((_) {
      setState(() { });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GestureDetector(
        child: VideoPlayer(
          _controller
        ),
        onTap: () {
          if (_controller.value.isPlaying) {
            _controller.pause();
          }
          else {
            _controller.play();
          }
        },
        onDoubleTap: () {
          _controller.seekTo(Duration(seconds: 0));
        },
      ),
    );
  }
}
