import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_video_editor/features/video_stream_feature/presentation/video_stream_screen.dart';
import 'package:flutter_video_editor/utils/video_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart' as video_th;

class VideoCard extends StatelessWidget {
  final VideoModel video;

  const VideoCard({
    required this.video,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(VideoScreen.id, arguments: video);
          },
          child: Card(
            child: SizedBox(
              width: double.infinity,
              height: 75,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      width: 120,
                      child: VideoThumbnail(video: video),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    child: SizedBox(
                      width: constraints.maxWidth - 140,
                      child: Text(
                        video.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class VideoThumbnail extends StatelessWidget {
  final VideoModel video;

  const VideoThumbnail({
    required this.video,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getVideoTh(videoUrl: video.videoURL),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return SizedBox(
            child: Image.asset('assets/image/image_error.png'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        } else {
          final newFile = File(snapshot.data!);

          return SizedBox(
            child: Image.file(newFile),
          );
        }

        return Container();
      },
    );
  }

  Future<String> getVideoTh({required String videoUrl}) async {
    String? path = await video_th.VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
    );

    if (path!.isEmpty || path == null) {
      return Future.error('unable to get thumbnail', StackTrace.current);
    } else {
      return path;
    }
  }
}
