import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:price_finder/features/select_image/controller/image_controller.dart';
import 'package:price_finder/utils/global_context_service.dart';
import 'package:rive/rive.dart';

import 'package:flutter/src/painting/gradient.dart' as gd;
// import 'features/select_image/view/get_image_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalContextService.navigatorKey, // set property
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImageController imageController = ImageController();
  late RiveAnimationController _searchButtonController;

  void _searchButtonFunction(RiveAnimationController controller){
    if(controller.isActive == false) {
      controller.isActive = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _searchButtonController = OneShotAnimation(
      'Animation 1',
      autoplay: false,
    );
  }

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
                    return imageController.selectImageDialog();
                  },
                  barrierDismissible: true,
                );
              },
              child: const Icon(Icons.search_rounded),
            ),
            const SizedBox(height: 120,
            ),
            GestureDetector(
              onTapDown: (_) => _searchButtonFunction(
                _searchButtonController,
              ),
              child: Container(
                width: 200,
                height: 200,
                // margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: RiveAnimation.asset(
                  'assets/buttons/search_button.riv',
                  controllers: [_searchButtonController,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(),
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
        child: Center(
          child: Container(
            width: 400,
            child: const RiveAnimation.asset(
                'assets/splash_screen/price_finder.riv'),
          ),
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
