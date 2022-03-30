import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_editor/presentation/paint_screen.dart';

void main() {
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
      initialRoute: PaintDrawer.id,
      onGenerateRoute: (settings) {
        if (settings.name == PaintDrawer.id) {
          return MaterialPageRoute(builder: (context) => const PaintDrawer());
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
      },
    );
  }
}
