import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_editor/features/cloud_storage_feature/presentation/cloud_storage_screen.dart';
import 'package:flutter_video_editor/config/app_router.dart';
import 'package:flutter_video_editor/utils/splash_screen.dart';
import 'package:flutter_video_editor/utils/theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const PaintApp());
}

class PaintApp extends StatelessWidget {
  const PaintApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
      theme: AppTheme.lightThemeData,
      darkTheme: AppTheme.darkThemeData,
      initialRoute: AppSplashScreen.id,
      onGenerateRoute: AppRouter.router,
    );
  }
}
