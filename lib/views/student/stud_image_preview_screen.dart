import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:sajili_mobile/routes/app_routes.dart';
import 'package:sajili_mobile/utils/custom_snack.dart';
import 'package:sajili_mobile/utils/image_utils.dart';

class StudImagePreviewScreen extends StatefulWidget {
  const StudImagePreviewScreen({super.key});

  @override
  State<StudImagePreviewScreen> createState() => _StudImagePreviewScreenState();
}

class _StudImagePreviewScreenState extends State<StudImagePreviewScreen> {
  bool isLoading = false;
  File? studImage;

  void _detectFace(File imageFile) async {
    setState(() => isLoading = true);

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
      final Uint8List bytes = await imageFile.readAsBytes();
      final Completer<ui.Image> completer = Completer();
      ui.decodeImageFromList(
          bytes, (ui.Image image) => completer.complete(image));
      final imageForBrightness = await completer.future;

      //* Brightness of the image
      double brightness = await calculateImageBrightness(imageForBrightness);

      if (brightness < 40) {
        Get.defaultDialog(
          title: 'Info',
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
          content: const Text('Please move to a location with more light'),
        );
        return;
      }

      //? Head euler angles
      bool correctHeadPosition = faces[0].headEulerAngleX! < 15 &&
          faces[0].headEulerAngleX! > -15 &&
          faces[0].headEulerAngleY! < 20 &&
          faces[0].headEulerAngleY! > -20 &&
          !(faces[0].headEulerAngleX == 0 &&
              faces[0].headEulerAngleY == 0 &&
              faces[0].headEulerAngleZ == 0);

      if (correctHeadPosition) {
        setState(() => studImage = imageFile);
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

    setState(() => isLoading = false);
  }

  void _takePicture() async {
    setState(() => isLoading = true);
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
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (studImage == null) {
          showSnack(
            'Info',
            'Please take a picture',
            Colors.orange[400]!,
            Icons.info_rounded,
            1,
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Image Preview'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Get.theme.colorScheme.secondary,
                    backgroundImage:
                        studImage != null ? FileImage(studImage!) : null,
                    radius: 120,
                    child: studImage == null
                        ? const Icon(
                            Icons.person_add_alt_1_rounded,
                            size: 40,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(height: 40),
                  studImage == null
                      ? const Text('No picture taken')
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: Get.mediaQuery.size.width * .7,
                          child: studImage == null
                              ? ElevatedButton(
                                  onPressed: _takePicture,
                                  child: const Text('Take picture'),
                                )
                              : ElevatedButton(
                                  onPressed: () => Get.back(result: studImage),
                                  child: const Text('Submit image'),
                                ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
