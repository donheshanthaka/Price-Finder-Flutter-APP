import 'dart:io';

// import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:price_finder/features/select_image/models/image_model.dart';
import 'package:price_finder/features/select_image/view/select_image_view.dart';
// import 'package:price_finder/main/app.dart';
// import 'package:price_finder/features/search_image/view/vehicle_page_view.dart';
import 'package:price_finder/features/search_image/controller/search_image_controller.dart';

class ImageController extends ControllerMVC {
  factory ImageController([StateMVC? state]) => _this ??= ImageController._(state);
  ImageController._(StateMVC? state)
      :super(state);
  static ImageController? _this;

   Future<File?> getImage(String imageSource){
    return ImageModel.getImage(imageSource);
   }

   SelectImageDialog selectImageDialog(){
    return SelectImageDialog();
   }

   callLoadVehiclePage(File image){
    SearchImageController searchImageController = SearchImageController();
    searchImageController.loadVehiclePage(image);
   }
}