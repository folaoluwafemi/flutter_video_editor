import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_editor/features/cloud_storage_feature/bloc/cloud_storage_cubit.dart';
import 'package:flutter_video_editor/features/cloud_storage_feature/presentation/util_widgets/video_card.dart';
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
    print('screen Init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Videos'),
        ),
        body: BlocBuilder<CloudStorageCubit, CloudStorageState>(
          builder: (blocBuilderCxt, state) => ListView.builder(
            itemCount: state.videoList.length,
            itemBuilder: (listViewContext, index) {
              return VideoCard(video: state.videoList[index]);
            },
          ),
        ),
      ),
    );
  }
}
