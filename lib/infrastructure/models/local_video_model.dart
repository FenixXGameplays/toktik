import 'package:toktik/domain/entities/video_post.dart';

class LocalVideoModel {
  final String caption;
  final String videoUrl;
   int likes;
   int views;

  LocalVideoModel(
      {
        required this.caption,
      required this.videoUrl,
      required this.likes,
      required this.views});

  factory LocalVideoModel.fromJsonMap(Map<String, dynamic> json) =>
      LocalVideoModel(
        caption: json["caption"],
        videoUrl: json["videoUrl"],
        views: int.tryParse(json["views"].toString()) ?? 0,
        likes: int.tryParse(json["likes"].toString()) ?? 0,
      );

  VideoPost toVideoPostEntity() => VideoPost(
    videoUrl: videoUrl,
        caption: caption,
        likes: likes,
        view: views,
      );
}
