import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/helpers/human_formats.dart';

import '../../../../domain/entities/video_post.dart';
import '../../../providers/discover_provider.dart';

class VideoButtons extends StatefulWidget {
  final VideoPost video;
  final String id;
  final int index;
  const VideoButtons({super.key,
    required this.id, required this.video, required this.index});

  @override
  State<VideoButtons> createState() => _VideoButtonsState();

}

class _VideoButtonsState extends State<VideoButtons> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _CustomIconButton(
          value: widget.video.likes,
          icon: Icons.favorite,
          iconColor: Colors.red,
          video: widget.video,
          index: widget.index,
          videoId: widget.id,
        ),
        const SizedBox(
          height: 8,
        ),
        _CustomIcon(value: widget.video.view, icon: Icons.remove_red_eye_outlined,),
        const SizedBox(
          height: 8,
        ),
        const SpinIcon(),
      ],
    );
  }
}

class _CustomIconButton extends StatefulWidget {
  final int value;
  final IconData icon;
  final Color? color;
  final VideoPost video;
  final String videoId;
  final int index;

  const _CustomIconButton(
      {required this.value,
      required this.icon,
      iconColor, required this.video, required this.videoId, required this.index
      }): color = iconColor ?? Colors.white;

  @override
  State<_CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<_CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(icon: Icon(widget.icon, color: widget.color, size: 30,), onPressed: (){
          incrementLikes(widget.video, widget.videoId, context, widget.index);
        },),
        Text(HumanFormats.humanReadableNumber(widget.value.toDouble())),
      ],
    );
  }

  void incrementLikes(VideoPost video, String videoId, BuildContext context, int index) async{
      final discProvider = Provider.of<DiscoverProvider>(context, listen: false);
      discProvider.videos[index].likes++;
      await discProvider.updateVideoLike(videoId, video.toJson());
    }
}


class _CustomIcon extends StatelessWidget {
  final int value;
  final IconData icon;
  final Color? color;

  const _CustomIcon(
      {required this.value,
        required this.icon,
        iconColor
      }): color = iconColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30,),
        Text(HumanFormats.humanReadableNumber(value.toDouble())),
      ],
    );
  }
}

class SpinIcon extends StatelessWidget {
  const SpinIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Spin(
      infinite: true,
    duration: const Duration(seconds: 2),
     child: const Center(child: Icon(Icons.play_circle_outline_outlined, size: 30,),));
  }
}
