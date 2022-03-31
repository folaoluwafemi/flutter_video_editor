import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_editor/utils/video_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoStreamState extends Equatable {
  final bool isPlaying;

  const VideoStreamState({required this.isPlaying});

  @override
  List<Object?> get props => [isPlaying];
}

class InitialVideoStreamState extends VideoStreamState {
  const InitialVideoStreamState() : super(isPlaying: false);
}

class VideoPausedState extends VideoStreamState {
  const VideoPausedState() : super(isPlaying: false);
}

class VideoPlayingState extends VideoStreamState {
  const VideoPlayingState() : super(isPlaying: true);
}

class VideoStreamCubit extends Cubit<VideoStreamState> {
  VideoStreamCubit() : super(const InitialVideoStreamState());

  VideoPlayerController initializeController({required VideoModel video}) {
    VideoPlayerController controller = VideoPlayerController.network(
      video.videoURL,
    );
    controller.initialize();
    controller.setVolume(1.0);

    emit(const InitialVideoStreamState());
    return controller;
  }

  void pause() {
    emit(const VideoPausedState());
  }

  void play() {
    emit(const VideoPlayingState());
  }
}
