import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:screenshot/screenshot.dart';

const String backGroundImage = 'assets/image/phone_background.jpg';

class PaintDrawer extends StatefulWidget {
  static const String id = '/paint_drawer';
  final Uint8List image;

  const PaintDrawer({required this.image, Key? key}) : super(key: key);

  @override
  _PaintDrawerState createState() => _PaintDrawerState();
}

class _PaintDrawerState extends State<PaintDrawer> {
  // Directory? localDir;
  // File? imageFileLocation;
  // Directory? imageDirectory;

  // dynamic initLocalDir() async {
  //   localDir = (await path_provider.getApplicationDocumentsDirectory());
  //   imageDirectory = Directory('${localDir!.path}/');
  //   imageFileLocation = File('${localDir!.path}/');
  //
  //   await imageFileLocation!.create();
  // }

  late PainterController painterController;
  ScreenshotController screenshotController = ScreenshotController();
  FocusNode textFocusNode = FocusNode();
  Paint shapePaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round;

  @override
  void initState() {
    painterController = PainterController(
      settings: PainterSettings(
        freeStyle: const FreeStyleSettings(
          mode: FreeStyleMode.draw,
          color: Colors.white,
          strokeWidth: 5,
        ),
        text: TextSettings(
          textStyle: const TextStyle(
            fontSize: 20,
          ),
          focusNode: textFocusNode,
        ),
      ),
    );

    textFocusNode.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    painterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(widget.image),
              ),
              color: Colors.transparent,
            ),
            child: FlutterPainter(
              controller: painterController,
            ),
          ),
        ],
      ),
    );
  }
}
