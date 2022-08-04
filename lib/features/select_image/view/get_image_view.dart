import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_finder/features/select_image/controller/image_controller.dart';

import '../../search_image/view/vehicle_page_view.dart';

class GetImage extends StatefulWidget {
  GetImage({Key? key}) : super(key: key);

  @override
  State<GetImage> createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  final ImageController imageController = ImageController();
  CupertinoAlertDialog _imageSourceAlertDialog(BuildContext context) {
    CupertinoDialogAction camera = CupertinoDialogAction(
        child: const Text('Camera'),
        onPressed: () async {
          final navigator = Navigator.of(context);
          navigator
              .pop(); // in case of error, put this beflow the getImage call
          final File? image = await imageController.getImage('camera');
          if (image != null) {
            navigator.push(MaterialPageRoute(builder: (context) => VehiclePage(image: image,)));
          }
        });

    CupertinoDialogAction gallery = CupertinoDialogAction(
        child: const Text('Gallery'),
        onPressed: () async {
          final navigator = Navigator.of(context);
          navigator.pop(); // in case of error, put this beflow the getImage call
          final File? image =
               await imageController.getImage('gallery');
          if (image != null){
            navigator.push(MaterialPageRoute(builder: (context) => VehiclePage(image: image,)));
          }
        });

    return CupertinoAlertDialog(
      title: const Text("Image source"),
      content: const Text("Select the image source"),
      actions: [gallery, camera],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _imageSourceAlertDialog(context);
  }
}




