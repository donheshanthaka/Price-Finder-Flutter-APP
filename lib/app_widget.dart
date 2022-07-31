import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:path/path.dart';
import 'package:price_finder/get_vehicle_info.dart';
import 'package:flutter/cupertino.dart';
//import 'package:price_finder/prediction.dart';
import 'package:price_finder/image_retrieval.dart';
import 'package:price_finder/failure.dart';
import 'package:price_finder/models/vehicle.dart';

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Finder'),
      ),
      body: Center(
        child: Column(
          children: [
            FloatingActionButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SearchButton();
                  },
                  barrierDismissible: true,
                );
              },
              child: const Icon(Icons.search_rounded),
            )
          ],
        ),
      ),
    );
  }
}

class SearchButton extends StatefulWidget {
  SearchButton({Key? key}) : super(key: key);

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  CupertinoAlertDialog _imageSourceAlertDialog(BuildContext context) {
    CupertinoDialogAction camera = CupertinoDialogAction(
        child: const Text('Camera'),
        onPressed: () async {
          final navigator = Navigator.of(context);
          navigator
              .pop(); // in case of error, put this beflow the getImage call
          final File? image = await ImageRetrieval.getImage(ImageSource.camera);
          if (image != null) {
            // final String vehicleName = await predictImage(image);
            // final String price = await getPrice(vehicleName);
            // await navigator.push(MaterialPageRoute(
            //   builder: (context) => Prediction(
            //     image: image,
            //     vehicleName: vehicleName,
            //     price: price,
            //   ),
            // ));
            navigator.push(MaterialPageRoute(builder: (context) => LoadingScreen(image: image,)));
          }
        });

    CupertinoDialogAction gallery = CupertinoDialogAction(
        child: const Text('Gallery'),
        onPressed: () async {
          final navigator = Navigator.of(context);
          navigator.pop(); // in case of error, put this beflow the getImage call
          final File? image =
              await ImageRetrieval.getImage(ImageSource.gallery);
          // if (image != null) {
          //   final String vehicleName = await predictImage(image);
          //   final String price = await getPrice(vehicleName);
          //   navigator.push(MaterialPageRoute(
          //     builder: (context) => Prediction(
          //       image: image,
          //       vehicleName: vehicleName,
          //       price: price,
          //     ),
          //   ));
          // }
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

Future<List<String>> getVehcileDetails() async {
  await Future.delayed(const Duration(seconds: 5));
  print('getVehcileName called');
  List<String> details = [];
  details.add("Wagon R");
  details.add(await getVehcilePrice("Wagon R"));
  return details;
  //throw const SocketException("No Internet");
  //throw Error("444");
}

Future<String> getVehcilePrice(String vehicleName) async {
  await Future.delayed(const Duration(seconds: 5));
  //print('getVehcilePrice called');
  //print(vehicleName);
  return "Rs. 6,500,000";
  //throw const SocketException("No Internet");
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


