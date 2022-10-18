import 'dart:io';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_provider/path_provider.dart';
import 'package:price_finder/features/select_image/models/image_model.dart';
import 'package:price_finder/features/select_image/view/select_image_view.dart';
import 'package:price_finder/features/search_image/controller/search_image_controller.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';

class ImageController extends ControllerMVC {
  factory ImageController([StateMVC? state]) =>
      _this ??= ImageController._(state);
  ImageController._(StateMVC? state) : super(state);
  static ImageController? _this;

  Future<File?> getImage(String imageSource) async {
    final image = await ImageModel.getImage(imageSource);
    final compressedImage = compressImage(image);
    return compressedImage;
  }

  SelectImageDialog selectImageDialog() {
    return SelectImageDialog();
  }

  callLoadVehiclePage(File image) {
    SearchImageController searchImageController = SearchImageController();
    searchImageController.loadVehiclePage(image);
  }

  Future<File?> compressImage(File? image) async {
    if (image != null) {
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyyMMddkkmms');
      final String formattedDate = formatter.format(now);
      final newPath =
          p.join((await getTemporaryDirectory()).path, '$formattedDate.jpeg');
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        image.path,
        newPath,
        quality: 25,
        format: CompressFormat.jpeg,
      );
      return compressedImage;
    }
    return image;
  }
}
