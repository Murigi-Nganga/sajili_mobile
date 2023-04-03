import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudTakePictureScreen extends StatefulWidget {
  const StudTakePictureScreen({
    super.key,
  });

  @override
  State<StudTakePictureScreen> createState() => _StudTakePictureScreenState();
}

class _StudTakePictureScreenState extends State<StudTakePictureScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(frontCamera, ResolutionPreset.medium);
    return _cameraController.initialize();
  }

  void _takePicture() async {
    try {
      await _initializeControllerFuture;
      // final appDirectory = await getApplicationDocumentsDirectory();
      // final imagePath = '${appDirectory.path}/image.jpg}';
      // final pictureFile = File(imagePath);
      final pictureFile = await _cameraController.takePicture();
      final image = File(pictureFile.path);
      Get.back<File>(result: image);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Picture'),
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(children: [
              const SizedBox(height: 10),
              const Text(
                'Take a photo',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              CameraPreview(_cameraController),
            ]);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: SizedBox(
        height: 75.0,
        width: 75.0,
        child: FittedBox(
          child: FloatingActionButton(
            tooltip: 'Take a selfie',
            onPressed: _takePicture,
            child: const Icon(Icons.camera_alt_rounded, color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
