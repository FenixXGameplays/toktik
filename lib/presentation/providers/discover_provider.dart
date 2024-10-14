//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/infrastructure/models/local_video_model.dart';
import 'package:toktik/shared/data/local_video_post.dart';

class DiscoverProvider extends ChangeNotifier{

  List<VideoPost> videos = [];
  List<String> videosId = [];
  bool initialLoading = true;



  Future<void> getVideos() async{
    var db = FirebaseFirestore.instance;
   await db.collection("videos").get().then(
          (querySnapshot) {

        for (var docSnapshot in querySnapshot.docs) {
          videos.add(LocalVideoModel.fromJsonMap(docSnapshot.data()).toVideoPostEntity());
          videosId.add(docSnapshot.id);
        }

      },
      onError: (e) => print("Error completing: $e"),
    );

    initialLoading = false;
    notifyListeners();
  }

  Future<void> updateVideoView(String id, Map<String, dynamic> newData) async{
    var db = FirebaseFirestore.instance;
    await db.collection("videos").doc(id).update(newData);

  }

  Future<void> updateVideoLike(String id, Map<String, dynamic> newData) async{
    var db = FirebaseFirestore.instance;
    await db.collection("videos").doc(id).update(newData);
    notifyListeners();
  }
}