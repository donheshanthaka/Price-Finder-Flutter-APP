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
import 'package:price_finder/features/search_image/view/search_view.dart';
import 'package:price_finder/common_screens/error_screen.dart';

class SearchImageController extends ControllerMVC {
  factory SearchImageController([StateMVC? state]) =>
      _this ??= SearchImageController._(state);
  SearchImageController._(StateMVC? state) : super(state);
  static SearchImageController? _this;

  Vehicle vehicle = Vehicle();

  Future<bool> getVehicleInfo(File image) async {
    String url = ConfigReader.getApiUrl();
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var multipartFile =
        await http.MultipartFile.fromPath('imageFile', image.path);
    request.files.add(multipartFile);

    try {
      var streamedResponse =
          await request.send().timeout(const Duration(seconds: 60));
      var response = await http.Response.fromStream(streamedResponse);
      final result =
          jsonDecode(response.body.toString()) as Map<String, dynamic>;
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

  String getModel() {
    return vehicle.getModel();
  }

  String getPriceFromModel() {
    return vehicle.getPrice();
  }

  loadVehiclePage(File image) {
    final context = GlobalContextService.navigatorKey.currentContext!;
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => VehiclePage(image: image)));
  }

  Widget loadSearchView(File image) {
    return SearchView(image: image);
  }

  Widget loadErrorScreen(String error) {
    return ErrorScreen(error: error);
  }
}
