import 'package:flutter/material.dart';
import 'package:price_finder/common_screens/splash_screen.dart';
import 'package:price_finder/utils/global_context_service.dart';

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
