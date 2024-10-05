// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_inoidsoft_app/presentation/providers/config_state_variables.dart';

import '../../constant.dart';

class TakePicture extends ConsumerWidget {
  Function(String path) updateImage;
  final ImagePicker _imagePicker = ImagePicker();

  String? selectedImagePath;

  TakePicture({super.key, required this.updateImage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    selectedImagePath = ref.watch(currentSelectedImageProvider);
    return showItemImages(ref);
  }

  /**
   *   Take Image Bibliografy
   *   Streamlining Image Selection with Flutter Image Picker Plugin
   *      https://www.dhiwise.com/post/streamlining-image-selection-with-flutter-image-picker-plugin
   * 
   *   Building an image picker in Flutter
   *     https://blog.logrocket.com/building-an-image-picker-in-flutter/
   * 
   *   Mastering Image Picking in Flutter with ImagePicker Plugin
   *     https://purvikrana.medium.com/mastering-image-picking-in-flutter-with-imagepicker-plugin-ee4d2429ad06
   * 
   *   image_picker: ^1.1.2
   *      https://pub.dev/packages/image_picker/example
   * 
   */
  Widget showItemImages(WidgetRef ref) {
    return Column(children: [
      selectedImagePath!.isEmpty
          ? Center(
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    width: 150,
                    height: 140,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(Icons.camera_alt_outlined,
                        color: Colors.black)),
              ),
            )
          : Center(
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: selectedImagePath!.contains("asset")
                          ? Image?.asset(selectedImagePath!, fit: BoxFit.cover)
                          : Image.file(File(selectedImagePath!),
                              fit: BoxFit.cover),
                    )),
              ),
            ),
      const SizedBox(
        height: 2,
      ),
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                color: kprimaryColor,
                onPressed: () => getImageFromSources(ref, ImageSource.gallery),
                icon: const Icon(
                  Icons.photo_album_outlined,
                )),
            IconButton(
                color: kprimaryColor,
                onPressed: () => getImageFromSources(ref, ImageSource.camera),
                icon: const Icon(
                  Icons.camera,
                )),
          ],
        ),
      )
    ]);
  }

  Future getImageFromSources(WidgetRef ref, ImageSource source) async {
    var image = await _imagePicker.pickImage(source: source);

    try {
      ref.read(currentSelectedImageProvider.notifier).updateImage = image!.path;
      updateImage(image!.path);
    } catch (e) {
      if (image is Null || image!.path is Null) {
        Fluttertoast.showToast(
            msg: ERROR_SELECT_IMAGE_FROM_GALLERY,
            toastLength: Toast.LENGTH_SHORT);
      }
    }
  }
}
