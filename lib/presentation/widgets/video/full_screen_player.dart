import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:toktik/presentation/widgets/video/video_background.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;

  const FullScreenPlayer({
    super.key,
    required this.videoUrl,
    required this.caption,
  });

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
   late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            onTap: () {
              if (controller.value.isPlaying) {
                controller.pause();
              } else {
                controller.play();
              }
            },
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(controller),
                  VideoBackground(),
                  Positioned(
                      bottom: 50,
                      left: 20,
                      child: _VideoCaption(caption: widget.caption),
                  )
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer() async{
    controller = VideoPlayerController.network(widget.videoUrl);
      final storageReference = FirebaseStorage.instance.ref().child(widget.videoUrl);
      final downloadUrl = await storageReference.getDownloadURL();

      controller = VideoPlayerController.network(downloadUrl)
        ..setVolume(0)
        ..setLooping(true)
        ..initialize()
        ..play();
      setState(() {

      });

  }
}

class _VideoCaption extends StatelessWidget {
  const _VideoCaption({
    required this.caption,
  });

  final String caption;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return SizedBox(
      width: size.width * 0.6,
      child: Text(
        caption,
        style: titleStyle,
        maxLines: 2,
      ),
    );
  }
}
