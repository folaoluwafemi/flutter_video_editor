import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_editor/features/cloud_storage_feature/presentation/cloud_storage_screen.dart';

class AppSplashScreen extends StatelessWidget {
  static const id = 'splash_screen';

  const AppSplashScreen({Key? key}) : super(key: key);

  Future<void> navigateToNextScreen(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1500)).then((value) {
      Navigator.of(context).pushNamed(VideosListScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    navigateToNextScreen(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.video_collection,
              color: Colors.blueGrey,
              size: 90,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Video Frame Editor',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
