import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_editor/features/cloud_storage_feature/bloc/cloud_storage_cubit.dart';
import 'package:flutter_video_editor/features/cloud_storage_feature/presentation/cloud_storage_screen.dart';
import 'package:flutter_video_editor/features/video_stream_feature/bloc/video_stream_cubit.dart';
import 'package:flutter_video_editor/features/video_stream_feature/presentation/video_stream_screen.dart';
import 'package:flutter_video_editor/features/annotate_frame_feature/presentation/paint_screen.dart';
import 'package:flutter_video_editor/utils/video_model.dart';

class AppRouter {
  static MaterialPageRoute router(RouteSettings settings) {
    if (settings.name == PaintDrawer.id) {
      Uint8List argumentImage = settings.arguments! as Uint8List;
      return MaterialPageRoute(
          builder: (context) => PaintDrawer(
                image: argumentImage,
              ));
    } else if (settings.name == VideosListScreen.id) {
      return MaterialPageRoute(
        builder: (_) => BlocProvider<CloudStorageCubit>(
          create: (_) => CloudStorageCubit(),
          child: const VideosListScreen(),
        ),
      );
    }

    if (settings.name == VideoScreen.id) {
      if (settings.arguments == null) {
        return MaterialPageRoute(
          builder: (_) {
            return const SafeArea(
              child: Scaffold(
                body: Center(
                  child: Text('you did not provide a valid Video'),
                ),
              ),
            );
          },
        );
      }
      VideoModel video = settings.arguments as VideoModel;

      return MaterialPageRoute(
        builder: (_) => BlocProvider<VideoStreamCubit>(
          create: (_) => VideoStreamCubit(),
          child: Builder(builder: (context) {
            return VideoScreen(video: video);
          }),
        ),
      );
    } else {
      return MaterialPageRoute(
        builder: (context) => const SafeArea(
          child: Scaffold(
            body: Center(
              child: Text('you navigated to the wrong route'),
            ),
          ),
        ),
      );
    }
  }
}
