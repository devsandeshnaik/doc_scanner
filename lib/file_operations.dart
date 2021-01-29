import 'dart:io';

import 'package:directory_picker/directory_picker.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';


import 'Classes.dart';


class FileOperations {
  String appName = 'DocScanner';
  static bool pdfStatus;






  // ADD IMAGES
  Future<File> openCamera() async {
    File image;
    final _picker = ImagePicker();
    var picture = await _picker.getImage(source: ImageSource.camera);
    if (picture != null) {
      final requiredPicture = File(picture.path);
      image = requiredPicture;
    }
    return image;
  }

  Future<File> openGallery() async {
    File image;
    final _picker = ImagePicker();
    var picture = await _picker.getImage(source: ImageSource.gallery);
    if (picture != null) {
      final requiredPicture = File(picture.path);
      image = requiredPicture;
    }
    return image;
  }

}
