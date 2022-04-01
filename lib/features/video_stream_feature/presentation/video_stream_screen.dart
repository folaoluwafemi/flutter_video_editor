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
  double position = 0.0;

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
    return LayoutBuilder(builder: (context, constraints) {
      videoController.setLooping(true);
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(constraints.maxWidth, 50),
            child: ValueListenableBuilder<VideoPlayerValue>(
              valueListenable: videoController,
              builder: (context, value, _) {
                return AppBar(
                  automaticallyImplyLeading: false,
                  actions: [
                    Visibility(
                      visible: !value.isPlaying,
                      child: IconButton(
                        onPressed: () async {
                          image = (await screenshotController.capture())!;
                          Future.delayed(const Duration(milliseconds: 300))
                              .then((value) {
                            Navigator.of(context)
                                .pushNamed(PaintDrawer.id, arguments: image);
                          });
                        },
                        icon: const Icon(
                          Icons.camera,
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
          body: Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: videoController.value.aspectRatio,
                  child: Stack(
                    children: [
                      Screenshot(
                        controller: screenshotController,
                        child: VideoPlayer(videoController),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Center(
                          child: RawMaterialButton(
                            shape: const CircleBorder(),
                            elevation: 0,
                            fillColor: Colors.transparent,
                            onPressed: () {
                              if (videoController.value.isPlaying) {
                                videoController.pause();
                                setState(() {});
                                context
                                    .read<VideoStreamCubit>()
                                    .pause(videoController);
                                return;
                              }
                              videoController.play();
                              setState(() {});
                              context
                                  .read<VideoStreamCubit>()
                                  .play(videoController);
                            },
                            child: Icon(
                              (videoController.value.isPlaying)
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 70,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: videoController.value.aspectRatio,
                    ),
                    ValueListenableBuilder<VideoPlayerValue>(
                        valueListenable: videoController,
                        builder: (context, value, _) {
                          return Container(
                            width: constraints.maxWidth,
                            color: Theme.of(context).backgroundColor,
                            height: 20,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Slider(
                                    value: value.position.inSeconds /
                                        value.duration.inSeconds,
                                    onChanged: (value) {},
                                  ),
                                ),
                                Text(
                                  '${value.position.inMinutes.toString()}:${(value.position.inSeconds % 60).toString()}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
