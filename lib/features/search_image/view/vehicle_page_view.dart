import 'dart:io';

import 'package:flutter/material.dart';
import 'package:price_finder/features/search_image/controller/search_image_controller.dart';
import 'package:flutter/src/painting/gradient.dart' as gd;
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        title: Text(
          'Vehicle',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(76),
          ),
        ),
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
                    height: ScreenUtil().screenHeight,
                    width: ScreenUtil().screenWidth,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: gd.RadialGradient(
                        center: const Alignment(0, -0.1),
                        radius: 3.7.r,
                        colors: const <Color>[
                          Color.fromARGB(223, 2, 22, 51),
                          Color.fromARGB(223, 1, 7, 26),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(210),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: ScreenUtil().setHeight(1245),
                              width: ScreenUtil().setWidth(1245),
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
                              height: ScreenUtil().setHeight(1150),
                              width: ScreenUtil().setWidth(1150),
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
                          padding: EdgeInsets.only(top: 280.h, left: 40.h, right: 40.h),
                          child: Text(
                            searchImageController.getModel(),
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(93),
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 215, 243, 255),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 125.h, left: 40.h, right: 40.h),
                          child: Text(
                            searchImageController.getPriceFromModel(),
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(93),
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 215, 243, 255),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return searchImageController
                      .loadErrorScreen("${snapshot.error}");
                } else {
                  return searchImageController.loadErrorScreen("No Data");
                }
            }
          },
        ),
      ),
    );
  }
}
