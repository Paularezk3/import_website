import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

class CustomChewieControls extends StatefulWidget {
  @override
  _CustomChewieControlsState createState() => _CustomChewieControlsState();
}

class _CustomChewieControlsState extends State<CustomChewieControls> {
  late ChewieController chewieController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    chewieController = ChewieController.of(context);
  }

  bool _controlsVisible = true; // Track visibility of controls
  double _opacity = 1.0; // Track opacity of controls
  void _toggleControlsVisibility({bool? visible}) {
    setState(() {
      _controlsVisible = visible ?? !_controlsVisible;
      _opacity = _controlsVisible ? 1.0 : 0.0;
    });
    _startHideTimer();
  }

  void _startHideTimer() {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _opacity = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _toggleControlsVisibility(visible: true);
      },
      onExit: (_) {
        _toggleControlsVisibility(visible: false);
      },
      child: Stack(
        children: [
          // Video player widget goes here
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 300), // Smooth animation
            child: GestureDetector(
              onTap: () {
                if (chewieController.isPlaying) {
                  chewieController.pause();
                }
                  _toggleControlsVisibility();
              },
              onDoubleTap: (){
                chewieController.togglePause();
              },
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black.withAlpha(150),
                child: Stack(
                  children: [
                    _buildPlayPauseButton(), // Always rendered, just opacity changes
                    _buildProgressBar(), // Always rendered, just opacity changes
                    _buildFullScreenButton(), // Always rendered, just opacity changes
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Positioned(
      bottom: 20.0,
      left: 10.0,
      right: chewieController.isFullScreen
          ? 70
          : 100.0, // Adjusted to account for full-screen button
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
            trackHeight: MediaQuery.of(context).size.width < 600
                ? 40
                : 20, // Make the progress bar thicker
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 20.0),
            thumbColor: Colors.blue,
            activeTrackColor: Colors.blue[300]),
        child: Slider(
          value: chewieController.videoPlayerController.value.position.inSeconds
              .toDouble(),
          max: chewieController.videoPlayerController.value.duration.inSeconds
              .toDouble(),
          onChanged: (value) {
            setState(() {
              chewieController.seekTo(Duration(seconds: value.toInt()));
            });
          },
        ),
      ),
    );
  }

  Widget _buildFullScreenButton() {
    return Positioned(
      right: 10.0,
      bottom: 10.0,
      child: IconButton(
        icon: Icon(
          chewieController.isFullScreen
              ? Icons.fullscreen_exit
              : Icons.fullscreen,
          color: Colors.white,
          size: MediaQuery.of(context).size.width < 600
              ? (chewieController.isFullScreen ? 60 : 160)
              : (chewieController.isFullScreen
                  ? 40
                  : 80.0), // Increase the size of the full-screen button
        ),
        onPressed: () {
          if (chewieController.isFullScreen) {
            chewieController.exitFullScreen();
          } else {
            chewieController.enterFullScreen();
          }
        },
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 8.0,
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(
            chewieController.isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: MediaQuery.of(context).size.width < 600? 200.0:120, // Larger size
          ),
          onPressed: () {
            setState(() {
              chewieController.isPlaying
                  ? chewieController.pause()
                  : chewieController.play();
            });
          },
        ),
      ),
    );
  }
}
