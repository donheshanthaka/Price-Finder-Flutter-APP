import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

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

  Future getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      // final imageTemp = File(image.path);
      final imageSaved = await saveImage(image.path);
      // debugPrint('Image Location >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
      // debugPrint(image.path);

      setState(() {
        _image = imageSaved;
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to display image: $e');
    }
  }

Future<File> saveImage(String imagePath) async {
  final direcotry = await getApplicationDocumentsDirectory();
  final name = basename(imagePath);
  final image = File('${direcotry.path}/$name');
  debugPrint('direcotry path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  debugPrint('${direcotry.path}/$name');

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
              onPressed: getImage,
              child: const Icon(Icons.search_rounded),
            )
          ],
        ),
      ),
    );
  }
}
