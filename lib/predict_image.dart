import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:price_finder/failure.dart';

Future<List<String>> predictImage(File file) async {
  //String url = "https://get-prediction-hezxtblxwq-el.a.run.app";
  String localPredUrl = "http://192.168.1.101:8000/"; // // use the current ip address by running ipconfig at the time of debugging using emulator
  
  //print('Image path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  //print(file.path);

  List<String> info = [];

  var request = http.MultipartRequest("POST", Uri.parse(localPredUrl));

  var multipartFile = await http.MultipartFile.fromPath('imageFile', file.path);

  request.files.add(multipartFile);

  try{
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var vehicleName = String.fromCharCodes(responseData);
      info.add(vehicleName);
      info.add(await getPrice(vehicleName));
      return info;
    } else {
      throw Exception("Falied to indentify image");
    }
  } on SocketException {
    throw Failure("Error: Cannot connect to server!");
  }
  
}

Future<String> getPrice(String vehicleName) async{
  Map<String, String> params = {"vehicle": vehicleName};
  String localPriceUrl = "http://192.168.1.101:8000/price"; // use the current ip address by running ipconfig at the time of debugging using emulator
  Uri url = Uri.parse(localPriceUrl);
  url = url.replace(queryParameters: params);
  final response = await http.get(url);
  if (response.statusCode == 200){
    return response.body;
  } else {
    throw Exception("Failed to get price");
  }
  
}