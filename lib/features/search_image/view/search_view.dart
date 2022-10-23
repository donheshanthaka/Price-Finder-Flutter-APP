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
                // height: 520,
                // width: 450,
                height: ScreenUtil().setHeight(1800),
                width: ScreenUtil().setWidth(1800),
                child: const RiveAnimation.asset(
                    'assets/ui_elements/search_loader_breathing.riv'),
              ),
              SizedBox(
                // height: 241,
                // width: 241,
                height: ScreenUtil().setHeight(900),
                width: ScreenUtil().setWidth(900),
                child:
                    const RiveAnimation.asset('assets/ui_elements/search_loader.riv'),
              ),
              Container(
                // width: 210,
                // height: 210,
                height: ScreenUtil().setHeight(785),
                width: ScreenUtil().setWidth(785),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: FileImage(widget.image), fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          SizedBox(
            // height: 50,
            // width: 50,
            height: ScreenUtil().setHeight(185),
            width: ScreenUtil().setWidth(185),
          ),
          Text(
            'Beta version could take up to 40 seconds due to server limitations.',
            style: TextStyle(
              color: const Color.fromARGB(157, 173, 212, 248),
              fontSize: ScreenUtil().setSp(45),
              // fontSize: (12),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
