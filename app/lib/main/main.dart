// ignore: prefer_relative_imports
import 'package:cloudwalk_challenge/main/my_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DevicePreview(builder: (context) => const MyApp()));
}
