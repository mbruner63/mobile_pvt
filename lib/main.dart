import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_pvt/mobile_pvt_disclaimer.dart';

//import 'package:flutter_launcher_icons/main.dart';

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
          visualDensity: VisualDensity.adaptivePlatformDensity,
//          appBarTheme: ,
          //primarySwatch: Colors.blue.shade900,
          //focusColor: Colors.blue.shade900,
          //primaryColor: Colors.blue.shade500,
          //colorScheme: colorScheme.copyWith(secondary:deepPurple.shade300),
          backgroundColor: Colors.grey[850],
          //backgroundColor: Colors.green,
          //primaryColor: Colors.blue.shade900,
          //accentColor: Colors.blue.shade900,
          //theme.copyWith(colorScheme: theme.colorScheme.copyWith(secondary:deepPurple.shade300)),
          //scaffoldBackgroundColor: Colors.red.shade300,
          //scaffoldBackgroundColor: Colors.grey.shade700,
          textTheme: const TextTheme(
              headline4: TextStyle(fontSize: 36, fontWeight: FontWeight.bold))),
      home: const DisclaimerPage(),
    );
  }
}
