import 'package:flutter/material.dart';



class ErrorScreen extends StatefulWidget {
final String error;
  ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
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
          Text(widget.error)
        ],
      ),
    );
  }
}