import 'dart:ffi';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:path_provider/path_provider.dart';

String deviceID = "Blah";
bool TrialFileFound = false;
bool TrialActive = false;
bool LicenseFileFound = false;
bool LicenseActive = false;
String CodedId = "";
Future<bool> setup_deviceID() async {
  String? _deviceId;
  BigInt mynum;
  try {
    _deviceId = await PlatformDeviceId.getDeviceId;
  } on PlatformException {
    _deviceId = '0123456789abcdef';
    return false;
  }
  mynum = BigInt.parse(_deviceId!, radix: 16).toUnsigned(32);
  deviceID = mynum.toString();
  mynum =
      (~(mynum + BigInt.from(0x881963)) - BigInt.from(0x881963)).toUnsigned(32);
  //Uint64 coded = mynum.toUnsigned(64) as Uint64; //as Uint64;

  //((~(mynum + BigInt.from(0x889163)))! - BigInt.from(0x889163)) as Uint64);;

  //Uint64 codedB = coded;
  print(_deviceId);
  print(deviceID);
  print("My num $mynum");
  return true;
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/disclaimer.txt');
}

Future<bool> readDisclaimerFile() async {
  try {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();

    return true;
  } catch (e) {
    // If encountering an error, return 0
    return false;
  }
}
