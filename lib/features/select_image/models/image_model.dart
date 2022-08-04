import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageModel {
  static Future<File?> getImage(String imageSource) async {
    late ImageSource source;
    if (imageSource == 'camera'){
      source = ImageSource.camera;
    } else if (imageSource == 'gallery'){
      source = ImageSource.gallery;
    }
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return null;
      //final savedImage = await _saveImage(image.path);

      //await predictImage(imageSaved);
      //return savedImage;
      return File(image.path);
    } on PlatformException catch (e) {
      print('Failed to display image: $e');
    }
    return null;
  }
}
