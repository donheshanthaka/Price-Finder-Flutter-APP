import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter/src/painting/gradient.dart' as gd;
import 'package:price_finder/features/select_image/controller/image_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  void _searchLoaderFunction(RiveAnimationController controller) {
    if (controller.isActive == false) {
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
    // double width = MediaQuery.of(context).size.width;
    // double heightFullScreen = MediaQuery.of(context).size.height;
    // var padding = MediaQuery.of(context).viewPadding;
    // double heightAdjusted = heightFullScreen - padding.top - kToolbarHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PRICE - FINDER',
          style: TextStyle(
            fontFamily: 'Chandstate',
            fontSize: ScreenUtil().setSp(76),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
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
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(400),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: ScreenUtil().setWidth(1750),
                    height: ScreenUtil().setHeight(1750),
                    child: const RiveAnimation.asset(
                      'assets/buttons/search_button_background.riv',
                    ),
                  ),
                  GestureDetector(
                    onTapDown: (_) => _searchButtonFunction(
                      _searchButtonController,
                    ),
                    child: Container(
                      width: ScreenUtil().setWidth(750),
                      height: ScreenUtil().setHeight(750),
                      key: const Key("SearchButton"),
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
