import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_video_editor/features/cloud_storage_feature/bloc/cloud_storage_cubit.dart';
import 'package:flutter_video_editor/firebase_options.dart';
import 'package:flutter_video_editor/utils/video_model.dart';

const String mockURL =
    'https://firebasestorage.googleapis.com/v0/b/video-editor-6a0f4.appspot.com/o/simplythreerollinginthedeepbyadeleofficialvideohi69541.3gp?alt=media&token=0dd8fa85-2b6b-4d09-9b1a-df243ea3a579';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  group('cloud storage cubit tests ', () {
    blocTest('test for initialized',
        build: () => CloudStorageCubit(),
        act: (CloudStorageCubit cubit) {
          cubit.onScreenInitialized();
          Future.delayed(const Duration(seconds: 1));
        },
        expect: () => [
              StorageScreenInitialized(videos: [VideoModel(videoURL: mockURL, name: 'some random name')])
            ]);
  });
}
