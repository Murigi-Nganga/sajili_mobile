import 'dart:async';
import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sajili_mobile/routes/app_routes.dart';
import 'package:sajili_mobile/student/controllers/stud_signup_controller.dart';
import 'package:sajili_mobile/widgets/auth_appbar.dart';
import 'package:sajili_mobile/widgets/image_card.dart';

// Face Detector class for the image
final faceDetector = FaceDetector(
  options: FaceDetectorOptions(
    enableClassification: true,
    enableLandmarks: true,
    enableTracking: true,
    enableContours: true,
    minFaceSize: 0.7,
    performanceMode: FaceDetectorMode.accurate,
  ),
);

class StudImageSignupScreen extends StatelessWidget {
  StudImageSignupScreen({super.key});

  final StudSignupController _signupController =
      Get.find<StudSignupController>();

  void _detectFace(File imageFile) async {
    _signupController.imageStatus(ImageStatus.loading);
    final faces = await faceDetector.processImage(
      InputImage.fromFile(imageFile),
    );

    if (faces.length != 1) {
      Get.defaultDialog(
          title: 'Image error',
          content: const Text('Image should contain a single face'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ]);
    } else {
      //? Without cropping
      // final Uint8List bytes = await imageFile.readAsBytes();
      // final Completer<ui.Image> completer = Completer();
      // ui.decodeImageFromList(
      //     bytes, (ui.Image image) => completer.complete(image));
      // final imageForBrightness = await completer.future;

      //? With cropping
      // final imageData = await selectedImage.readAsBytes();
      // final ui.Image rawImage = await decodeImageFromList(imageData);
      // final cropRect = Rect.fromLTWH(
      //   faces.first.boundingBox.left.toDouble(),
      //   faces.first.boundingBox.top.toDouble(),
      //   faces.first.boundingBox.width.toDouble(),
      //   faces.first.boundingBox.height.toDouble(),
      // );

      // final croppedImage = await cropImage(rawImage, cropRect);

      //* Brightness of the image
      // print('${await _calculateImageBrightness(imageForBrightness)}');

      //? Euler angles
      // print('HEAD EULER ANGLES:\

      bool correctHeadPosition = faces[0].headEulerAngleX! < 15 &&
          faces[0].headEulerAngleX! > -15 &&
          faces[0].headEulerAngleY! < 20 &&
          faces[0].headEulerAngleY! > -20 &&
          !(faces[0].headEulerAngleX == 0 &&
              faces[0].headEulerAngleY == 0 &&
              faces[0].headEulerAngleZ == 0);

      if (correctHeadPosition) {
        _signupController.image(imageFile);
      } else {
        Get.defaultDialog(
          title: 'Info',
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
          content: const Text('Incorrect head position'),
        );
      }
    }
    _signupController.imageStatus(ImageStatus.done);
  }

  Future<void> _getImageFromGallery() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      _detectFace(File(pickedFile!.path));
    } catch (error) {
      Get.defaultDialog(
        title: 'Info',
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
        content: const Text('No image selected from gallery'),
      );
    }
  }

  void _takePhoto() async {
    try {
      final File imageFile = await Get.toNamed(Routes.studTakePictureRoute);
      _detectFace(imageFile);
    } catch (error) {
      Get.defaultDialog(
        title: 'Info',
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
        content: const Text('No photo captured'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppbar(title: 'Sign Up'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 70),
          child: Column(
            children: [
              const Text(
                'Upload your image or take a photo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  backgroundImage: _signupController.image.value != null
                      ? FileImage(_signupController.image.value!)
                      : null,
                  radius: 100,
                  child: _signupController.image.value == null
                      ? const Icon(
                          Icons.person_add_alt_1_rounded,
                          size: 40,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 40),
              Obx(
                () => _signupController.imageStatus.value == ImageStatus.loading
                    ? const CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ImageCard(
                            onTap: _takePhoto,
                            cardText: 'Take Photo',
                            cardIcon: Icons.camera_alt_rounded,
                          ),
                          ImageCard(
                            onTap: _getImageFromGallery,
                            cardText: 'Upload Image',
                            cardIcon: Icons.image_rounded,
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: ElevatedButton(
                  //! Call signup service
                  onPressed: () => Get.offAllNamed(Routes.studLoginRoute),
                  child: const Text('Register'),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: LinearProgressIndicator(
                  value: 1.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.secondary),
                  backgroundColor: Colors.black26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//? Calculate image brightness
//! In preview
  // Future<double> _calculateImageBrightness(ui.Image image) async {
  //   // New image byte data buffer
  //   final buffer = await image.toByteData();

  //   double brightness = 0.0;

  //   for (var i = 0; i < buffer!.lengthInBytes; i += 4) {
  //     final r = buffer.getUint8(i);
  //     final g = buffer.getUint8(i + 1);
  //     final b = buffer.getUint8(i + 2);

  //     brightness += 0.2126 * r + 0.7152 * g + 0.0722 * b;
  //   }

  //   return brightness / (buffer.lengthInBytes / 4);
  // }

  // Future<ui.Image> cropImage(ui.Image rawImage, Rect cropRect) async {
  //   final croppedImage =
  //       await rawImage.toByteData(format: ui.ImageByteFormat.png);
  //   final bytes = croppedImage!.buffer.asUint8List(
  //     cropRect.left.toInt(),
  //     cropRect.top.toInt(),
  //     cropRect.right.toInt(),
  //   );

  //   return await decodeImageFromList(bytes);
  // }
