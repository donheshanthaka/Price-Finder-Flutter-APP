import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:price_finder/predict_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:price_finder/prediction.dart';

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
  // File? _image;

  // Future<File?> getImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return null;
  //     final imageSaved = await saveImage(image.path);
  //     setState(() {
  //       _image = imageSaved;
  //     });
  //     //await predictImage(imageSaved);
  //     return _image;
  //   } on PlatformException catch (e) {
  //     debugPrint('Failed to display image: $e');
  //   }
  // }

  // Future<File> saveImage(String imagePath) async {
  //   final direcotry = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File('${direcotry.path}/$name');
  //   return File(imagePath).copy(image.path);
  // }

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
                    //return imageSourceAlertDialog(getImage, context);
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


// CupertinoAlertDialog imageSourceAlertDialog(
//     Function getImage, BuildContext context) {
//   //File? image;
//   var cam = CupertinoDialogAction(
//       child: const Text('Camera'),
//       onPressed: () async {
//         // print("Camera");
//         final navigator = Navigator.of(context);
//         final File? image = await getImage(ImageSource.camera);
//         navigator.pop();
//         //navigatorPop.pop();
//         if (image != null){
//           await navigator.push(
//             MaterialPageRoute(builder: (context) => Prediction(image: image,)));
//         }
//       });
//   var gal = CupertinoDialogAction(
//       child: const Text('Gallery'),
//       onPressed: () async {
//         // print("Gallery");
//         //final navigatorPop = Navigator.of(context, rootNavigator: true);
//         //final navigatorRoute = Navigator.push(context, MaterialPageRoute(builder: ));
//         final navigator = Navigator.of(context);
//         final File? image = await getImage(ImageSource.gallery);
//         navigator.pop();
//         //navigatorPop.pop();
//         if (image != null){
//           navigator.push(
//             MaterialPageRoute(builder: (context) => Prediction(image: image,)));
//         }
//         //navigator.pop();
//       });

//   return CupertinoAlertDialog(
//     title: const Text("Image source"),
//     content: const Text("Select the image source"),
//     actions: [gal, cam],
//   );
// }



class SearchButton extends StatefulWidget {
  SearchButton({Key? key}) : super(key: key);

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {


  Future<File?> _getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return null;
      final savedImage = await _saveImage(image.path);

      //await predictImage(imageSaved);
      return savedImage;
    } on PlatformException catch (e) {
      debugPrint('Failed to display image: $e');
    }
    return null;
  }

  Future<File> _saveImage(String imagePath) async {
    final direcotry = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${direcotry.path}/$name');
    return File(imagePath).copy(image.path);
  }

  CupertinoAlertDialog _imageSourceAlertDialog(
    BuildContext context) {

  CupertinoDialogAction camera = CupertinoDialogAction(
      child: const Text('Camera'),
      onPressed: () async {
        final navigator = Navigator.of(context);
        navigator.pop(); // in case of error, put this beflow the _getImage call
        final File? image = await _getImage(ImageSource.camera);
        if (image != null){
          await navigator.push(
            MaterialPageRoute(builder: (context) => Prediction(image: image,)));
        }
      });
  
  CupertinoDialogAction gallery = CupertinoDialogAction(
      child: const Text('Gallery'),
      onPressed: () async {
        final navigator = Navigator.of(context);
        navigator.pop(); // in case of error, put this beflow the _getImage call
        final File? image = await _getImage(ImageSource.gallery);
        if (image != null){
          navigator.push(
            MaterialPageRoute(builder: (context) => Prediction(image: image,)));
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


