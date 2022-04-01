import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_editor/utils/video_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:video_player/video_player.dart';

abstract class VideoStreamState extends Equatable {
  final double? position;
  final bool isPlaying;

  const VideoStreamState({required this.isPlaying, this.position});

  @override
  List<Object?> get props => [isPlaying, position];
}

class InitialVideoStreamState extends VideoStreamState {
  const InitialVideoStreamState() : super(isPlaying: false);
}

class VideoPausedState extends VideoStreamState {
  const VideoPausedState({required double position})
      : super(isPlaying: false, position: position);
}

class VideoPlayingState extends VideoStreamState {
  const VideoPlayingState({required double position})
      : super(isPlaying: true, position: position);
}

class VideoStreamCubit extends Cubit<VideoStreamState> {
  VideoStreamCubit() : super(const InitialVideoStreamState());

  VideoPlayerController initializeController({required VideoModel video}) {
    VideoPlayerController controller = VideoPlayerController.network(
      video.videoURL,
    )..setLooping(true);
    controller.initialize();
    controller.setVolume(1.0);

    emit(const InitialVideoStreamState());
    return controller;
  }

  double getCurrentPosition(VideoPlayerController videoController) {
    var newPosition = videoController.value.position.inSeconds /
        videoController.value.duration.inSeconds;
    return newPosition;
  }

  void pause(VideoPlayerController controller) {
    double position = getCurrentPosition(controller);

    emit(VideoPausedState(position: position));
  }

  void play(VideoPlayerController controller) {
    double position = getCurrentPosition(controller);
    emit(VideoPlayingState(position: position));
  }
}
