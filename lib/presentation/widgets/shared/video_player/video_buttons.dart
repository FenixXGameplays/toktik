import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:toktik/config/theme/helpers/human_formats.dart';

class VideoButtons extends StatelessWidget {
  final int likes;
  final int views;
  const VideoButtons({super.key, required this.likes, required this.views});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _CustomIconButton(value: likes, icon: Icons.favorite, iconColor: Colors.red),
        const SizedBox(
          height: 8,
        ),
        _CustomIconButton(value: views, icon: Icons.remove_red_eye_outlined,),
        const SizedBox(
          height: 8,
        ),
        const SpinIcon(),
      ],
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  final int value;
  final IconData icon;
  final Color? color;

  const _CustomIconButton(
      {required this.value,
      required this.icon,
      iconColor
      }): color = iconColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(icon: Icon(icon, color: color, size: 30,), onPressed: (){},),
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
