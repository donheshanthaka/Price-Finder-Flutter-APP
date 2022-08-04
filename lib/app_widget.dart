import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'features/select_image/view/get_image.dart';


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
                    return GetImage();
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

