import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/widgets/shared/video_scrollable_view.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final discProvider = context.watch<DiscoverProvider>();

    return  Scaffold(
      body: discProvider.initialLoading
      ? const Center(
        child: CircularProgressIndicator.adaptive(),
      )
      : VideoScrollableView(videos: discProvider.videos, videosId: discProvider.videosId,)
    );
  }
}