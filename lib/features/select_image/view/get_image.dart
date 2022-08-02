import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_finder/features/select_image/controller/image_controller.dart';

import '../../../get_vehicle_info.dart';
import '../../search_image/models/vehicle_model.dart';

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
            navigator.push(MaterialPageRoute(builder: (context) => LoadingScreen(image: image,)));
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
            navigator.push(MaterialPageRoute(builder: (context) => LoadingScreen(image: image,)));
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





class LoadingScreen extends StatefulWidget {
  final File image;
  const LoadingScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // final Future<List<String>> _vehicleDetails = getVehcileDetails();
  //late LoadingScreen image;
  //final Future<List<String>> _vehicleDetails = predictImage(image.getImage());
  // late Future<List<String>> _vehicleDetails;

  // @override
  // void initState(){
  //   super.initState();
  //   _vehicleDetails = predictImage();
  // }

  late Future<Vehicle> vehicle;

  @override
  void initState() {
    super.initState();
    vehicle = getVehicleInfo(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading'),
      ),
      body: Center(
        child: FutureBuilder<Vehicle>(
          future: vehicle,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.done:
              default:
                if (snapshot.hasData) {
                  print(snapshot.data!.model);
                  print(snapshot.data!.price);
                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Image.file(
                          widget.image,
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(45.0),
                          child: Text(
                            snapshot.data!.model,
                            //"Wagon R Stingray 2018",
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 59, 77, 85),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            snapshot.data!.price,
                            //"Rs. 6,000,000",
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 59, 77, 85),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return const Text("No Data");
                }
            }
          },
        ),
      ),
    );
  }
}


