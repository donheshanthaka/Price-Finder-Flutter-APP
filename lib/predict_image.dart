import 'package:http/http.dart' as http;
import 'dart:io';

predictImage(File file) async {
  print(
      'Image path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  print(file.path);

  var request = http.MultipartRequest(
      "POST", Uri.parse("https://get-prediction-hezxtblxwq-el.a.run.app"));
      
  var multipartFile =
      await http.MultipartFile.fromPath('imageFile', file.path);

  request.files.add(multipartFile);

  var response = await request.send();

  var responseData = await response.stream.toBytes();

  var result = String.fromCharCodes(responseData);

  print(result);
}
