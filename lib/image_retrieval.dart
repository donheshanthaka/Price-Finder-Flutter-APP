import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageRetrieval{

  static Future<File?> getImage(ImageSource source) async {
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

  // Future<File> _saveImage(String imagePath) async {
  //   final direcotry = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File('${direcotry.path}/$name');
  //   return File(imagePath).copy(image.path);
  // }
}