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
                return SearchView(image: widget.image,);
              case ConnectionState.done:
              default:
                if (snapshot.hasData) {
                  // print(snapshot.data!.model);
                  // print(snapshot.data!.price);
                  return SearchView(image: widget.image,);
                  // return Center(
                  //   child: Column(
                  //     children: [
                  //       const SizedBox(
                  //         height: 40,
                  //       ),
                  //       Image.file(
                  //         widget.image,
                  //         width: 250,
                  //         height: 250,
                  //         fit: BoxFit.cover,
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.all(45.0),
                  //         child: Text(
                  //           searchImageController.getModel(),
                  //           // snapshot.data!.model,
                  //           //"Wagon R Stingray 2018",
                  //           style: const TextStyle(
                  //             fontSize: 25,
                  //             fontWeight: FontWeight.bold,
                  //             color: Color.fromARGB(255, 59, 77, 85),
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.all(1.0),
                  //         child: Text(
                  //           searchImageController.getPriceFromModel(),
                  //           // snapshot.data!.price,
                  //           //"Rs. 6,000,000",
                  //           style: const TextStyle(
                  //             fontSize: 25,
                  //             fontWeight: FontWeight.bold,
                  //             color: Color.fromARGB(255, 59, 77, 85),
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // );
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
      child: Stack(alignment: Alignment.center, children: [
        Container(
          width: 420,
          // width: 380,
          child: const RiveAnimation.asset(
              'assets/ui_elements/search_loader_breathing.riv'),
        ),
        Container(
          width: 241,
          // width: 380,
          child:
              const RiveAnimation.asset('assets/ui_elements/search_loader.riv'),
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
        // Text('Beta version could take upto 40 seconds due to server limitations.')
        Text('Beta version.')
      ]),
    );
  }
}
