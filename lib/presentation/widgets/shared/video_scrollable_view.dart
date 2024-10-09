import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/presentation/widgets/shared/video_player/video_buttons.dart';
import 'package:toktik/presentation/widgets/video/full_screen_player.dart';

class VideoScrollableView extends StatelessWidget {
  final List<VideoPost> videos;
  const VideoScrollableView({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final video = videos[index];
        return Stack(
          children: [
            SizedBox.expand(
              child: FullScreenPlayer(
                videoUrl: video.videoUrl,
                caption: video.caption,
              ),
            ),
            //VideoController
            Positioned(
              bottom: 40,
              right: 20,
              child: VideoButtons(
                likes: video.likes,
                views: video.view,
              ),
            )
          ],
        );
      },
      itemCount: videos.length,
    );
  }
}
