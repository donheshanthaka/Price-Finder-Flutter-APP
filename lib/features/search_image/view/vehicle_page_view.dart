import 'dart:io';

import 'package:flutter/material.dart';
import 'package:price_finder/features/search_image/controller/search_image_controller.dart';
// import '../../search_image/models/vehicle_model.dart';




class VehiclePage extends StatefulWidget {
  final File image;
  const VehiclePage({Key? key, required this.image}) : super(key: key);

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  
  final SearchImageController searchImageController = SearchImageController();

  // late Future<Vehicle> vehicle;

  late Future<bool> success;

  // late Future<List> dum;

  @override
  void initState() {
    super.initState();
    // vehicle = getVehicleInfo(widget.image);
    success = searchImageController.getVehicleInfo(widget.image);
    // dum = predictImage(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading'),
      ),
      body: Center(
        child: FutureBuilder<bool>(
          future: success,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.done:
              default:
                if (snapshot.hasData) {
                  // print(snapshot.data!.model);
                  // print(snapshot.data!.price);
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
                            searchImageController.getModel(),
                            // snapshot.data!.model,
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
                            searchImageController.getPriceFromModel(),
                            // snapshot.data!.price,
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
