import 'dart:io';

import 'package:flutter/material.dart';
import 'package:price_finder/features/search_image/controller/search_image_controller.dart';
import 'package:rive/rive.dart';
import 'package:flutter/src/painting/gradient.dart' as gd;
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
        title: const Text('Vehicle'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<bool>(
          future: success,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return SearchView(
                  image: widget.image,
                );
              case ConnectionState.done:
              default:
                if (snapshot.hasData) {
                  // print(snapshot.data!.model);
                  // print(snapshot.data!.price);
                  // return SearchView(image: widget.image,);
                  return Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        gradient: gd.RadialGradient(
                            center: Alignment(0, -0.1),
                            radius: 1,
                            colors: <Color>[
                          Color.fromARGB(223, 2, 22, 51),
                          Color.fromARGB(223, 1, 7, 26),
                        ])),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          width: 310,
                          height: 310,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: FileImage(widget.image),
                                fit: BoxFit.cover),
                            border: Border.all(
                              color: const Color.fromARGB(255, 24, 149, 187),
                              width: 10,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 10.0,
                                spreadRadius: 0.0,
                              )
                            ],
                          ),
                        ),

                        // Container(
                        //   width: 700,
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     border: Border.all(
                        //       color: Colors.red,
                        //       width: 10,
                        //     )
                        //   ),
                        //   child: CircleAvatar(
                        //     radius: 150,
                        //     backgroundImage: FileImage(widget.image),
                        //   ),
                        // ),
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


class SearchView extends StatefulWidget {
  final File image;
  SearchView({Key? key, required this.image}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          gradient: gd.RadialGradient(
              center: Alignment(0, -0.1),
              radius: 1,
              colors: <Color>[
            Color.fromARGB(223, 2, 22, 51),
            Color.fromARGB(223, 1, 7, 26),
          ])),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
            width: 60,
          ),
          Stack(alignment: Alignment.center, children: [
            const SizedBox(
              height: 520,
              width: 450,
              // width: 380,
              child: RiveAnimation.asset(
                  'assets/ui_elements/search_loader_breathing.riv'),
            ),
            const SizedBox(
              height: 241,
              width: 241,
              // width: 380,
              child:
                  RiveAnimation.asset('assets/ui_elements/search_loader.riv'),
            ),
            Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: FileImage(widget.image), fit: BoxFit.cover),
              ),
            ),
          ]),
          const SizedBox(
            height: 50,
            width: 50,
          ),
          const Text('Beta version could take up to 40 seconds due to server limitations.',
          style: TextStyle(
            color: Color.fromARGB(157, 173, 212, 248),
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),)
        ], 
      ),
    );
  }
}
