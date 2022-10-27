import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter/src/painting/gradient.dart' as gd;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchView extends StatefulWidget {
  final File image;
  const SearchView({Key? key, required this.image}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
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
            height: ScreenUtil().setHeight(200),
            width: ScreenUtil().setWidth(200),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(1800),
                width: ScreenUtil().setWidth(1800),
                child: const RiveAnimation.asset(
                    'assets/ui_elements/search_loader_breathing.riv'),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(850),
                width: ScreenUtil().setWidth(850),
                child: const RiveAnimation.asset(
                    'assets/ui_elements/search_loader.riv'),
              ),
              Container(
                height: ScreenUtil().setHeight(740),
                width: ScreenUtil().setWidth(740),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: FileImage(widget.image), fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(185),
            width: ScreenUtil().setWidth(185),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.h, right: 20.h),
            child: Text(
              'Beta version could take up to 40 seconds due to server limitations.',
              style: TextStyle(
                color: const Color.fromARGB(157, 173, 212, 248),
                fontSize: ScreenUtil().setSp(45),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
