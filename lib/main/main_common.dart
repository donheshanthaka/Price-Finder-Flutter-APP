import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_finder/utils/config_reader.dart';
import 'package:price_finder/main/app.dart';


Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize(env);

  runApp(const MyApp());
}