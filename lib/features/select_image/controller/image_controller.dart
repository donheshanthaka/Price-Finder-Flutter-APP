import 'dart:io';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:price_finder/features/select_image/models/image_model.dart';

class ImageController extends ControllerMVC {
  factory ImageController([StateMVC? state]) => _this ??= ImageController._(state);
  ImageController._(StateMVC? state)
      :super(state);
  static ImageController? _this;

   Future<File?> getImage(String imageSource){
    return Image.getImage(imageSource);
   }
}