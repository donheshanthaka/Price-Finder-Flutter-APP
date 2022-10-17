import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter/src/painting/gradient.dart' as gd;
import 'package:price_finder/common_screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreenView(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 26, 39, 56),
      body: Container(
        decoration: const BoxDecoration(
            gradient: gd.RadialGradient(
                center: Alignment(0, -0.1),
                radius: 1,
                colors: <Color>[
              Color.fromARGB(223, 2, 22, 51),
              Color.fromARGB(223, 1, 7, 26),
            ])),
        child: const Center(
          child: SizedBox(
            width: 400,
            child:
                RiveAnimation.asset('assets/splash_screen/splash_screen.riv'),
          ),
        ),
      ),
    );
  }
}
