import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorScreen extends StatefulWidget {
  final String error;
  const ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: RadialGradient(
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
            height: ScreenUtil().setHeight(462.5),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(928),
            width: ScreenUtil().setWidth(928),
            child: Image.asset(
                'assets/ui_elements/error_icons/broken_search_icon.png'),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(210),
          ),
          Padding(
            padding: EdgeInsets.all(70.h),
            child: Text(
              widget.error,
              style: TextStyle(
                color: const Color.fromARGB(157, 173, 212, 248),
                fontSize: 67.sp,
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
