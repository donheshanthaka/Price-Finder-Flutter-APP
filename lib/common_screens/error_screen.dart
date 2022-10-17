import 'package:flutter/material.dart';

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
          const SizedBox(
            height: 125,
          ),
          SizedBox(
            height: 250,
            width: 250,
            child: Image.asset(
                'assets/ui_elements/error_icons/broken_search_icon.png'),
          ),
          const SizedBox(
            height: 55,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget.error,
              style: const TextStyle(
                color: Color.fromARGB(157, 173, 212, 248),
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
