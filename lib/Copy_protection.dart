import 'dart:ffi';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

String deviceID = "Blah";
String? _deviceId; // = "Starting";
bool TrialFileFound = false;
bool TrialActive = false;
bool LicenseFileFound = false;
bool LicenseActive = false;

bool FileFound = false;

String CodedId = "";
Future<bool> setup_deviceID() async {
  //String? _deviceId;
  BigInt mynum;
  try {
    _deviceId = await PlatformDeviceId.getDeviceId;
  } on PlatformException {
    _deviceId = '0123456789abcdef';
    return false;
  }
  mynum = BigInt.parse(_deviceId!, radix: 16).toUnsigned(32);
  mynum =
      (~(mynum + BigInt.from(0x881963)) - BigInt.from(0x881963)).toUnsigned(32);
  deviceID = mynum.toString();

  print("num1 $_deviceId");
  print("num2 $deviceID");
  print("My num $mynum");
  return true;
}

//Jordan's Playing
Future<bool> find_file() async {
  final path = (await getExternalStorageDirectory())!.path;
  final file = deviceID;
  final deviceId = _deviceId;
  print('$path/$file.bin');
  final content = await File('$path/$file.bin').exists();

  if (content == true) {
    print("this file exists");
    print("deviceID $deviceId");

    // Delete File for testing purposes
    final content = await File('$path/$file.bin').delete();

    return true;
  } else {
    print("this file doesn't exist");
    var create = await File('$path/$file.bin');
    var trialend = (DateTime.now().millisecondsSinceEpoch / 1000).round() +
        10 * 24 * 60 * 60;
    create.writeAsString('$trialend');
    print('Trial $trialend');
    print("deviceID $deviceId");
    // If file doesn't exist, email id to tom to create
    final Email email = Email(
      body: 'Device ID: $deviceId',
      subject: "mobile_pvt: PVT file",
      recipients: [
        "marty@bruner-consulting.com",
        // "tomk@ambulatory-monitoring.com",
      ],
      isHTML: false,
    );
    try {
      await FlutterEmailSender.send(email);
      print('success');
    } catch (error) {
      print(error.toString());
      print(email.recipients);
    }

    return false;
  }
  // try {
  //
  //
  //   return true;
  // } catch {
  //   print('error with find_file');
  //   return false;
  // }
}

Future<File> get writeFile async {
  //final path = await _localPath;
  final path = (await getExternalStorageDirectory())!.path;
  final file = deviceID;
  print('$path/$file.bin');
  return File('$path/$file.bin');
}

//Jordan's done

// Future<bool> readPVTFile() async {
//   try {
//     final file = await _localFile;
//     print("contents of PVT file");
//     // Read the file
//     final contents = await file.readAsString();
//     print(contents);
//
//     return true;
//   } catch (e) {
//     // If encountering an error, return 0
//     print("something bad happened dude!");
//     return false;
//   }
// }

// Future<String> get _localPath async {
//   final directory = await getApplicationDocumentsDirectory();
//
//   return directory.path;
// }
//
// Future<File> get _localFile async {
//   final path = await _localPath;
//   return File('$path/disclaimer.txt');
// }
//
// Future<bool> readDisclaimerFile() async {
//   try {
//     final file = await _localFile;
//
//     // Read the file
//     final contents = await file.readAsString();
//
//     return true;
//   } catch (e) {
//     // If encountering an error, return 0
//     return false;
//   }
// }
