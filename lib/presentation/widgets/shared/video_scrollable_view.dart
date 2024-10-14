import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/presentation/widgets/shared/video_player/video_buttons.dart';
import 'package:toktik/presentation/widgets/video/full_screen_player.dart';

import '../../../infrastructure/models/local_video_model.dart';
import '../../providers/discover_provider.dart';

class VideoScrollableView extends StatelessWidget {
  final List<VideoPost> videos;
  final List<String> videosId;
  const VideoScrollableView({super.key,
    required this.videos,
    required this.videosId});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final video = videos[index];
        final videoId = videosId[index];
        incrementView( video, videoId, context, index);
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
                video: video,
                index: index,
                id: videoId
              ),
            )
          ],
        );
      },
      itemCount: videos.length,
    );
  }

  void incrementView(VideoPost video, String videoId, BuildContext context, int index) async{
    final discProvider = context.watch<DiscoverProvider>();
    discProvider.videos[index].view++;
    discProvider.updateVideoView(videoId, video.toJson());
  }
}
