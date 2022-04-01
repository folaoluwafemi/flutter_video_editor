import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
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
  late PainterController painterController;
  ScreenshotController screenshotController = ScreenshotController();
  FocusNode textFocusNode = FocusNode();

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                painterController.clearDrawables();
              },
              icon: const Icon(Icons.cancel_outlined),
            ),
            IconButton(
              onPressed: () {
                setState(() {});
                if (painterController.canUndo) {
                  return painterController.undo();
                }
              },
              icon: const Icon(Icons.undo),
            ),
            IconButton(
              onPressed: () {
                if (painterController.canUndo) {
                  setState(() {
                    painterController.redo();
                  });
                }
              },
              icon: const Icon(Icons.redo),
            ),
            IconButton(
              onPressed: () async {
                await screenshotController
                    .capture(delay: const Duration(milliseconds: 300))
                    .then((value) {
                  if (value != null) {
                    ImageGallerySaver.saveImage(value);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Image has been saved successfully')),
                    );
                  }
                });
              },
              icon: const Icon(Icons.save),
            )
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Screenshot(
          controller: screenshotController,
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
        ),
      ),
    );
  }
}
