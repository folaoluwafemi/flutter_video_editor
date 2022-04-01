import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_video_editor/features/cloud_storage_feature/model/cloud_storage_model.dart';
import 'package:flutter_video_editor/utils/video_model.dart';

const String myVideo =
    'simplythreerollinginthedeepbyadeleofficialvideohi69541.3gp';

class CloudStorageRepository {
  CloudStorageModel storageModel = CloudStorageModel();

  Future<ListResult> get _videoLists async {
    return await storageModel.storage.ref().listAll();
  }

  Future<List<VideoModel>> get videos async {
    List<VideoModel> videoList = [];
    // List<Reference> newList = (await _videoLists).items;
    // for (var element in newList) {
    //   VideoModel video = VideoModel(
    //     name: element.name,
    //    videoURL: await element.getDownloadURL(),
    //   );
    //   videoList.add(video);
    // }
    
    videoList.add(VideoModel(name: 'butterfly.mp4', videoURL: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));
    return videoList;
  }
}
