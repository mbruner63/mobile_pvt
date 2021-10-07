import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mobile_pvt/mobile_pvt_disclaimer.dart';

int sessionTime = 60; //default to test time;
late DateTime startTime;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Tremor Measurement POC App',
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.deepPurple.shade900,
          accentColor: Colors.deepPurple.shade300,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          backgroundColor: Colors.grey.shade900,
          textTheme: const TextTheme(
              headline4: TextStyle(fontSize: 36, fontWeight: FontWeight.bold))),
      home: const DisclaimerPage(),
    );
  }
}
