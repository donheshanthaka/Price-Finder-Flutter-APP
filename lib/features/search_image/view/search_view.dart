import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter/src/painting/gradient.dart' as gd;

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
          const SizedBox(
            height: 60,
            width: 60,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                height: 520,
                width: 450,
                child: RiveAnimation.asset(
                    'assets/ui_elements/search_loader_breathing.riv'),
              ),
              const SizedBox(
                height: 241,
                width: 241,
                child:
                    RiveAnimation.asset('assets/ui_elements/search_loader.riv'),
              ),
              Container(
                width: 210,
                height: 210,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: FileImage(widget.image), fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
            width: 50,
          ),
          const Text(
            'Beta version could take up to 40 seconds due to server limitations.',
            style: TextStyle(
              color: Color.fromARGB(157, 173, 212, 248),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
