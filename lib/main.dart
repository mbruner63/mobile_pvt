import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
//import 'package:mobile_pvt/password_page.dart';
import 'package:mobile_pvt/mobile_pvt_disclaimer.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:platform_device_id/platform_device_id.dart';

import 'Copy_protection.dart';

//import 'package:flutter_launcher_icons/main.dart';
FlutterBlue flutterBlue = FlutterBlue.instance;
int sessionTime = 60; //default to test time;
late DateTime startTime;
String realDeviceID = 'nothing';
Widget startPage = DisclaimerPage();
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await setup_deviceID();
  // await find_file();
  //print(deviceID);
  //realDeviceID = deviceID!;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Mobile PVT POC App ',
      debugShowCheckedModeBanner: false,
//aqua blue theme
      theme: FlexThemeData.light(
        scheme: FlexScheme.aquaBlue,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 18,
        appBarStyle: FlexAppBarStyle.primary,
        appBarOpacity: 0.95,
        appBarElevation: 0,
        transparentStatusBar: true,
        tabBarStyle: FlexTabBarStyle.forAppBar,
        tooltipsMatchBackground: true,
        swapColors: false,
        lightIsWhite: false,
        useSubThemes: true,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        // To use this font, add GoogleFonts package and uncomment:
        // fontFamily: GoogleFonts.notoSans().fontFamily,
        subThemesData: const FlexSubThemesData(
          useTextTheme: true,
          fabUseShape: true,
          interactionEffects: true,
          bottomNavigationBarOpacity: 0.95,
          bottomNavigationBarElevation: 0,
          inputDecoratorIsFilled: true,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorUnfocusedHasBorder: true,
          blendOnColors: true,
          blendTextTheme: true,
          popupMenuOpacity: 0.95,
        ),
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.aquaBlue,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 18,
        appBarStyle: FlexAppBarStyle.background,
        appBarOpacity: 0.95,
        appBarElevation: 0,
        transparentStatusBar: true,
        tabBarStyle: FlexTabBarStyle.forAppBar,
        tooltipsMatchBackground: true,
        swapColors: false,
        darkIsTrueBlack: false,
        useSubThemes: true,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        // To use this font, add GoogleFonts package and uncomment:
        // fontFamily: GoogleFonts.notoSans().fontFamily,
        subThemesData: const FlexSubThemesData(
          useTextTheme: true,
          fabUseShape: true,
          interactionEffects: true,
          bottomNavigationBarOpacity: 0.95,
          bottomNavigationBarElevation: 0,
          inputDecoratorIsFilled: true,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorUnfocusedHasBorder: true,
          blendOnColors: true,
          blendTextTheme: true,
          popupMenuOpacity: 0.95,
        ),
      ),
//       theme: ThemeData(
//           brightness: Brightness.dark,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
// //          appBarTheme: ,
//           //primarySwatch: Colors.blue.shade900,
//           //focusColor: Colors.blue.shade900,
//           //primaryColor: Colors.blue.shade500,
//           //colorScheme: colorScheme.copyWith(secondary:deepPurple.shade300),
//           backgroundColor: Colors.grey[850],
//           //backgroundColor: Colors.green,
//           //primaryColor: Colors.blue.shade900,
//           //accentColor: Colors.blue.shade900,
//           //theme.copyWith(colorScheme: theme.colorScheme.copyWith(secondary:deepPurple.shade300)),
//           //scaffoldBackgroundColor: Colors.red.shade300,
//           //scaffoldBackgroundColor: Colors.grey.shade700,
//           textTheme: const TextTheme(
//               headline4: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
//       ),
      home: startPage,
    );
  }
}
