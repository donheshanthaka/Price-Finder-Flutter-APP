import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import 'package:price_finder/common_screens/splash_screen.dart';
// import 'package:price_finder/features/select_image/controller/image_controller.dart';
import 'package:price_finder/utils/global_context_service.dart';
// import 'package:rive/rive.dart';

// import 'package:flutter/src/painting/gradient.dart' as gd;
// import 'features/select_image/view/get_image_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalContextService.navigatorKey, // set property
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 26, 41, 65),
        ),
      ),
      home: const SplashScreen(),
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
