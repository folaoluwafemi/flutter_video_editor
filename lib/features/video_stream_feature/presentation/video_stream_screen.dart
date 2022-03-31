import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_editor/features/annotate_frame_feature/presentation/paint_screen.dart';
import 'package:flutter_video_editor/features/video_stream_feature/bloc/video_stream_cubit.dart';
import 'package:flutter_video_editor/utils/video_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  static const String id = '/video_stream_screen';
  final VideoModel video;

  const VideoScreen({
    required this.video,
    Key? key,
  }) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController videoController;
  late ScreenshotController screenshotController;
  late Uint8List image;

  @override
  void initState() {
    screenshotController = ScreenshotController();
    videoController = BlocProvider.of<VideoStreamCubit>(context)
        .initializeController(video: widget.video);

    super.initState();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  FocusNode textFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () async {
                  image = (await screenshotController.capture())!;
                  Future.delayed(const Duration(milliseconds: 300))
                      .then((value) {
                    Navigator.of(context)
                        .pushNamed(PaintDrawer.id, arguments: image);
                  });
                },
                icon: const Icon(
                  Icons.add,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey,
        body: Center(
          child: Container(
            color: Colors.transparent,
            child: AspectRatio(
              aspectRatio: videoController.value.aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Screenshot(
                    controller: screenshotController,
                    child: VideoPlayer(videoController),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: RawMaterialButton(
                        fillColor: Colors.grey.withOpacity(0.3),
                        onPressed: () {
                          if (videoController.value.isPlaying) {
                            videoController.pause();
                            context.read<VideoStreamCubit>().pause();
                            return;
                          }
                          videoController.play();
                          context.read<VideoStreamCubit>().play();
                        },
                        child: const Text('this button'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
