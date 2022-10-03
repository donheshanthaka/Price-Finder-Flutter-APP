import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:flutter/src/painting/gradient.dart' as gd;

import '../features/select_image/controller/image_controller.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final ImageController imageController = ImageController();
  late RiveAnimationController _searchButtonController;
  late RiveAnimationController _searchLoaderController;

  void _searchButtonFunction(RiveAnimationController controller) {
    if (controller.isActive == false) {
      controller.isActive = true;
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return imageController.selectImageDialog();
      },
      barrierDismissible: true,
    );
  }

  void _searchLoaderFunction(RiveAnimationController controller){
    if(controller.isActive == false){
      controller.isActive = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _searchButtonController = OneShotAnimation(
      'button_press',
      autoplay: false,
    );
    _searchLoaderController = SimpleAnimation(
      'loader_animation',
      autoplay: true,
    );
    _searchLoaderFunction(_searchLoaderController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PRICE - FINDER', style: TextStyle(fontFamily: 'Chandstate')),
        centerTitle: true,
      ),
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
          child: Column(
            children: [
              // FloatingActionButton(
              //   onPressed: () {
              //     showCupertinoDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return imageController.selectImageDialog();
              //       },
              //       barrierDismissible: true,
              //     );
              //   },
              //   child: const Icon(Icons.search_rounded),
              // ),
              // const SizedBox(height: 100,
              // ),
              // const Text('Tap to search',
              // ),
              const SizedBox(
                height: 150,
              ),

              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 470,
                    height: 470,
                    // decoration: const BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: Colors.black
                    //   ),
                    child: const RiveAnimation.asset(
                      'assets/buttons/search_button_background.riv',
                    ),
                  ),
                  GestureDetector(
                    onTapDown: (_) => _searchButtonFunction(
                      _searchButtonController,
                    ),
                    child: Container(
                      width: 200,
                      height: 200,
                      // margin: EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: RiveAnimation.asset(
                        'assets/buttons/search_button.riv',
                        controllers: [
                          _searchButtonController,
                          _searchLoaderController,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}