import 'dart:io';

import 'package:http/http.dart' as http;

Future<String> predictImage(File file) async {
  //String url = "https://get-prediction-hezxtblxwq-el.a.run.app";
  String localPredUrl = "http://192.168.1.100:8000/";
  
  //print('Image path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  //print(file.path);
  var request = http.MultipartRequest("POST", Uri.parse(localPredUrl));

  var multipartFile = await http.MultipartFile.fromPath('imageFile', file.path);

  request.files.add(multipartFile);

  var response = await request.send();
  if (response.statusCode == 200) {
    var responseData = await response.stream.toBytes();
    var prediction = String.fromCharCodes(responseData);
    print(prediction);
    return prediction;
  } else {
    throw Exception("Falied to indentify image");
  }
}

Future<String> getPrice(String vehicleName) async{
  Map<String, String> params = {"vehicle": vehicleName};
  String localPriceUrl = "http://192.168.1.100:8000/price";
  Uri url = Uri.parse(localPriceUrl);
  url = url.replace(queryParameters: params);
  final response = await http.get(url);
  print(response.body);
  return response.body;
}