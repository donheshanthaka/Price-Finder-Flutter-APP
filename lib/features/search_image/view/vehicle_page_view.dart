import 'dart:io';

import 'package:flutter/material.dart';
import 'package:price_finder/features/search_image/controller/search_image_controller.dart';
import 'package:flutter/src/painting/gradient.dart' as gd;

class VehiclePage extends StatefulWidget {
  final File image;
  const VehiclePage({Key? key, required this.image}) : super(key: key);

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  final SearchImageController searchImageController = SearchImageController();

  late Future<bool> success;

  @override
  void initState() {
    super.initState();
    success = searchImageController.getVehicleInfo(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<bool>(
          future: success,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return searchImageController.loadSearchView(widget.image);
              case ConnectionState.done:
              default:
                if (snapshot.hasData) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: gd.RadialGradient(
                        center: Alignment(0, -0.1),
                        radius: 1,
                        colors: <Color>[
                          Color.fromARGB(223, 2, 22, 51),
                          Color.fromARGB(223, 1, 7, 26),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 335,
                              width: 335,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(141, 48, 141, 223),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(141, 48, 141, 223),
                                    blurRadius: 10.0,
                                    spreadRadius: 5.0,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 310,
                              height: 310,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(widget.image),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 75, 0, 20),
                          child: Text(
                            searchImageController.getModel(),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 215, 243, 255),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Text(
                            searchImageController.getPriceFromModel(),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 215, 243, 255),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return searchImageController
                      .loadErrorScreen("${snapshot.error}");
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
