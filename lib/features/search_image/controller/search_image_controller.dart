import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:price_finder/utils/failure.dart';
import 'package:price_finder/features/search_image/models/vehicle_model_update.dart';
import 'package:price_finder/utils/config_reader.dart';
import 'package:price_finder/features/search_image/view/vehicle_page_view.dart';
import 'package:price_finder/utils/global_context_service.dart';

class SearchImageController extends ControllerMVC {
  factory SearchImageController([StateMVC? state]) =>
      _this ??= SearchImageController._(state);
  SearchImageController._(StateMVC? state): super(state);
  static SearchImageController? _this;
  
  Vehicle vehicle = Vehicle();

  Future<List<String>> predictImage(File file) async {
    //String url = "https://get-prediction-hezxtblxwq-el.a.run.app";
    String localPredUrl =
        "http://192.168.1.101:8000/"; // // use the current ip address by running ipconfig at the time of debugging using emulator

    //print('Image path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    //print(file.path);

    List<String> info = [];

    var request = http.MultipartRequest("POST", Uri.parse(localPredUrl));

    var multipartFile =
        await http.MultipartFile.fromPath('imageFile', file.path);

    request.files.add(multipartFile);

    try {
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

  Future<String> getPrice(String vehicleName) async {
    Map<String, String> params = {"vehicle": vehicleName};
    String localPriceUrl =
        "http://192.168.1.101:8000/price"; // use the current ip address by running ipconfig at the time of debugging using emulator
    Uri url = Uri.parse(localPriceUrl);
    url = url.replace(queryParameters: params);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed to get price");
    }
  }

  Future<bool> getVehicleInfo(File image) async {
    // String url = '${ConfigReader.getApiUrl()}/test';
    String url = ConfigReader.getApiUrl();
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var multipartFile =
        await http.MultipartFile.fromPath('imageFile', image.path);
    request.files.add(multipartFile);

    try {
      var streamedResponse =
          await request.send().timeout(const Duration(seconds: 60));
      var response = await http.Response.fromStream(streamedResponse);
      final result = jsonDecode(response.body.toString()) as Map<String, dynamic>;
      if (streamedResponse.statusCode == 200) {
        vehicle.updateInfo(result);
        return true;
      } else if (streamedResponse.statusCode != 200) {
        throw Failure('Error: ${result['message']}');
      } else {
        throw Failure(
            'Error: Unexpected error occured, please contact support!');
      }
    } on SocketException {
      throw Failure("Error: Cannot connect to server!");
    } on TimeoutException {
      throw Failure("Error: Server timeout!");
    }
  }

  String getModel(){
    return vehicle.getModel();
  }

  String getPriceFromModel(){
    return vehicle.getprice();
  }

  loadVehiclePage(File image){
    final context = GlobalContextService.navigatorKey.currentContext!;
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => VehiclePage(image: image)));
   }
  
}
