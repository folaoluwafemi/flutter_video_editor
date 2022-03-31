import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_editor/features/cloud_storage_feature/model/cloud_storage_repository.dart';
import 'package:flutter_video_editor/utils/video_model.dart';

class CloudStorageState extends Equatable {
  final List<VideoModel> videoList;

  const CloudStorageState({required this.videoList});

  @override
  List<Object?> get props => [videoList];
}

class InitialStorageState extends CloudStorageState {
  const InitialStorageState() : super(videoList: const []);
}

class StorageScreenInitialized extends CloudStorageState {
  final List<VideoModel> videos;

  const StorageScreenInitialized({required this.videos})
      : super(videoList: videos);
}

class CloudStorageCubit extends Cubit<CloudStorageState> {
  CloudStorageRepository repository = CloudStorageRepository();

  CloudStorageCubit() : super(const InitialStorageState());

  Future<void> onScreenInitialized() async {
    List<VideoModel> cloudVideos = await repository.videos;

    emit(StorageScreenInitialized(videos: cloudVideos));
  }
}
