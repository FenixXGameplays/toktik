//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/infrastructure/models/local_video_model.dart';
import 'package:toktik/shared/data/local_video_post.dart';

class DiscoverProvider extends ChangeNotifier{

  List<VideoPost> videos = [];
  bool initialLoading = true;


  Future<void> getVideos() async{
    var db = FirebaseFirestore.instance;
   await db.collection("videos").get().then(
          (querySnapshot) {

        for (var docSnapshot in querySnapshot.docs) {
          videos.add(LocalVideoModel.fromJsonMap(docSnapshot.data()).toVideoPostEntity());
        }

      },
      onError: (e) => print("Error completing: $e"),
    );



    initialLoading = false;
    notifyListeners();
  }
}