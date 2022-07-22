import 'dart:io';

import 'package:flutter/material.dart';

class Prediction extends StatelessWidget {
  //Prediction({Key? key}) : super(key: key);

  File? image;

  Prediction({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prediction"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            image != null
                ? Image.file(
                    image!,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                : Image.network('https://picsum.photos/250?imaghe=9'),
            const Padding(
              padding: EdgeInsets.all(45.0),
              child: Text(
                "Wagon R Stingray 2018",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 59, 77, 85),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(1.0),
              child: Text(
                "Rs. 6,000,000",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 59, 77, 85),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
