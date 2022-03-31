import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_editor/features/cloud_storage_feature/bloc/cloud_storage_cubit.dart';
import 'package:flutter_video_editor/features/video_stream_feature/presentation/video_stream_screen.dart';
import 'package:flutter_video_editor/utils/video_model.dart';

class VideosListScreen extends StatefulWidget {
  static const String id = '/video_list_screen';

  const VideosListScreen({Key? key}) : super(key: key);

  @override
  _VideosListScreenState createState() => _VideosListScreenState();
}

class _VideosListScreenState extends State<VideosListScreen> {
  late List<VideoModel> videosList;

  @override
  void initState() {
    context.read<CloudStorageCubit>().onScreenInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.blueGrey,
          child: BlocBuilder<CloudStorageCubit, CloudStorageState>(
            builder: (blocBuilderCxt, state) => ListView.builder(
              itemCount: state.videoList.length,
              itemBuilder: (listViewContext, index) {
                return VideoCard(video: state.videoList[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final VideoModel video;

  const VideoCard({
    required this.video,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      color: Colors.grey,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(VideoScreen.id, arguments: video);
        },
        child: Card(
          child: Text(video.videoURL),
        ),
      ),
    );
  }
}
