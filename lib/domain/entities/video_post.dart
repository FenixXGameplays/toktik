class VideoPost {
  final String caption;
  final String videoUrl;
   int likes;
   int view;

VideoPost(
   {
    required this.caption,
    required this.videoUrl,
    required this.likes,
     required this.view,
});

  Map<String, dynamic> toJson() => {
    "caption": caption,
    "videoUrl": videoUrl,
    "views": view,
    "likes": likes,
  };

}