import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:price_finder/predict_image.dart';

import 'package:flutter/cupertino.dart';

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
  File? _image;

  Future<File?> getImage(ImageSource source, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return null;
      final imageSaved = await saveImage(image.path);
      setState(() {
        _image = imageSaved;
      });
      await predictImage(imageSaved);
      return _image;
    } on PlatformException catch (e) {
      debugPrint('Failed to display image: $e');
    }
  }

  Future<File> saveImage(String imagePath) async {
    final direcotry = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${direcotry.path}/$name');
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Finder'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            _image != null
                ? Image.file(
                    _image!,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                : Image.network('https://picsum.photos/250?imaghe=9'),
            const SizedBox(
              height: 40,
            ),
            FloatingActionButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return imageSourceAlertDialog(getImage, context);
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

Future<File?> imageFile(Function getImage, BuildContext context) async{
  final File? image = await getImage(ImageSource.gallery, context);
  return image;
}

CupertinoAlertDialog imageSourceAlertDialog(
    Function getImage, BuildContext context) {
  File? image;
  var cam = CupertinoDialogAction(
      child: const Text('Camera'),
      onPressed: () {
        // print("Camera");
        final File? image = getImage(ImageSource.camera, context);
        //image = imageFile(getImage, context);
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Prediction(image: image)));
      });

  var gal = CupertinoDialogAction(
      child: const Text('Gallery'),
      onPressed: () async {
        // print("Gallery");
        final File? image = await getImage(ImageSource.gallery, context);
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Prediction(image: image,)));
      });

  return CupertinoAlertDialog(
    title: const Text("Image source"),
    content: const Text("Select the image source"),
    actions: [gal, cam],
  );
}

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
          ],
        ),
      ),
    );
  }
}
