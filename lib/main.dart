import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:path/path.dart';
import 'package:price_finder/predict_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:price_finder/prediction.dart';
import 'package:price_finder/image_retrieval.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Finder'),
      ),
      body: Center(
        child: Column(
          children: [
            FloatingActionButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SearchButton();
                  },
                  barrierDismissible: true,
                );
              },
              child: const Icon(Icons.search_rounded),
            )
          ],
        ),
      ),
    );
  }
}

class SearchButton extends StatefulWidget {
  SearchButton({Key? key}) : super(key: key);

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  CupertinoAlertDialog _imageSourceAlertDialog(BuildContext context) {
    CupertinoDialogAction camera = CupertinoDialogAction(
        child: const Text('Camera'),
        onPressed: () async {
          final navigator = Navigator.of(context);
          navigator
              .pop(); // in case of error, put this beflow the getImage call
          final File? image = await ImageRetrieval.getImage(ImageSource.camera);
          if (image != null) {
            await navigator.push(MaterialPageRoute(
              builder: (context) => Prediction(
                image: image,
              ),
            ));
          }
        });

    CupertinoDialogAction gallery = CupertinoDialogAction(
        child: const Text('Gallery'),
        onPressed: () async {
          final navigator = Navigator.of(context);
          navigator
              .pop(); // in case of error, put this beflow the getImage call
          final File? image =
              await ImageRetrieval.getImage(ImageSource.gallery);
          if (image != null) {
            navigator.push(MaterialPageRoute(
              builder: (context) => Prediction(
                image: image,
              ),
            ));
          }
        });

    return CupertinoAlertDialog(
      title: const Text("Image source"),
      content: const Text("Select the image source"),
      actions: [gallery, camera],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _imageSourceAlertDialog(context);
  }
}
