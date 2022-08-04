import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:price_finder/constants/environment.dart';

abstract class ConfigReader {
  static late Map<String, dynamic> _config;

  static Future<void> initialize(String env) async {
    late String path;
    switch (env){
      case Environment.dev:
        path = 'assets/config/app_config_dev.json';
        break;
      case Environment.prod:
        path = 'assets/config/app_config_prod.json';
        break;
    }
    final configString = await rootBundle.loadString(path);
    _config = json.decode(configString) as Map<String, dynamic>;
  }

  static String getApiUrl() {
    return _config['API_URL'] as String;
  }
}