import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MovieWidget extends StatefulWidget {
  final String movieURL;
  const MovieWidget({Key? key, required this.movieURL}) : super(key: key);

  @override
  State<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(widget.movieURL)
      ..initialize().then((_) {
        setState(() {
          _controller!.play();
        });
      });
    _controller!.setLooping(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return Container();
    }
    return AspectRatio(
      aspectRatio: 1.0,
      child: VideoPlayer(_controller!),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
