import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_finder/config_reader.dart';
import 'package:price_finder/app.dart';


Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize(env);

  runApp(const MyApp());
}