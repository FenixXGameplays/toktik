import 'package:flutter/material.dart';

class VideoBackground extends StatelessWidget {
  const VideoBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black
            ],
          ),
        ),
      ),
    );
  }
}

