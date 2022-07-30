import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:price_finder/failure.dart';
import 'package:price_finder/models/vehicle.dart';

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
    var response = await request.send().timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var vehicleName = String.fromCharCodes(responseData);
      info.add(vehicleName);
      info.add(await getPrice(vehicleName));
      return info;
    } else {
      throw Exception("Error: Falied to indentify image");
    }
  } on SocketException {
    throw Failure("Error: Cannot connect to server!");
  } on TimeoutException {
    throw Failure("Error: Server timeout!");
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


Future<Vehicle> getVehicleInfo(File image) async {
  String localUrl =
      "http://192.168.1.102:8000/test"; // // use the current ip address by running ipconfig at the time of debugging using emulator
  var request = http.MultipartRequest("POST", Uri.parse(localUrl));
  var multipartFile =
      await http.MultipartFile.fromPath('imageFile', image.path);
  request.files.add(multipartFile);

  try {
    var streamedResponse =
        await request.send().timeout(const Duration(seconds: 10));
    if (streamedResponse.statusCode == 200) {
      var response = await http.Response.fromStream(streamedResponse);
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      return Vehicle.fromJson(result);
    } else if (streamedResponse.statusCode == 415) {
      throw Failure("Error: Invalid image type");
    } else {
      throw Failure('Error: Unexpected error occured, please contact support!');
    }
  } on SocketException {
    throw Failure("Error: Cannot connect to server!");
  } on TimeoutException {
    throw Failure("Error: Server timeout!");
  }
}
