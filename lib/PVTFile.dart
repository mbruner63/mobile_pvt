import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_pvt/rating_page.dart';
import 'package:mobile_pvt/session_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'AfterRating.dart';
import 'Copy_protection.dart';
import 'PVTData.dart';
import 'main.dart';

String pvt_filename = "";
Future<String?> get _localPath async {
  WidgetsFlutterBinding.ensureInitialized();
  //final directory = await getApplicationDocumentsDirectory();
  final Directory? directory = await getExternalStorageDirectory();

  return directory?.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  print('$path/testfile.pvt');
  final mydate = DateTime.now();

  pvt_filename = androidId.toString() +
      "_" +
      pvt_data.S_ID.toString() +
      "_" +
      mydate.month.toString() +
      "_" +
      mydate.day.toString() +
      "_" +
      mydate.year.toString() +
      "_" +
      mydate.hour.toString() +
      "_" +
      mydate.minute.toString() +
      ".pvt";
  print('$path/$pvt_filename');
  return File('$path/$pvt_filename');
}

Future<bool> readPVTFile() async {
  try {
    final file = await _localFile;
    print("contents of PVT file");
    // Read the file
    final contents = await file.readAsString();
    print(contents);

    return true;
  } catch (e) {
    // If encountering an error, return 0
    print("something bad happened dude!");
    return false;
  }
}

Future<File> writePVTFile() async {
  final file = await _localFile;
  try {
    await file.delete;
  } catch (e) {
    print(e);
  }
  print("writing file");
  try {
    await file.writeAsString("hey hey my my");
    file.writeAsStringSync("\r\n\"PVT DATA\" \r\n");
    file.writeAsStringSync("\"STUDY: \", \"${pvt_data.Study}\" \r\n",
        mode: FileMode.append);
    file.writeAsStringSync(
        "\"RATING PRE, POST TRIAL: \",${pvt_data.Before_Rating},${pvt_data.After_Rating}\r\n",
        mode: FileMode.append);
    file.writeAsStringSync("\"E. INITIALS:\", \"${pvt_data.E_Initials}\"\r\n",
        mode: FileMode.append);
    file.writeAsStringSync("\"S. INITIALS:\", \"${pvt_data.S_Initials}\"\r\n",
        mode: FileMode.append);
    file.writeAsStringSync("\"S. ID NUMBER:\", ${pvt_data.S_ID}\r\n",
        mode: FileMode.append);
    file.writeAsStringSync("\"TRIAL NUMBER:\", ${pvt_data.Trial_Number} \r\n",
        mode: FileMode.append);
    file.writeAsStringSync("\"TRIAL DATE:\", \"${pvt_data.Trial_Date}\"\r\n",
        mode: FileMode.append);
    file.writeAsStringSync("\"TRIAL TIME:\", \"${pvt_data.Trial_Time}\" \r\n",
        mode: FileMode.append);
    file.writeAsStringSync("\"ISI MIN (ms):\", ${pvt_data.ISI_Min}  \r\n",
        mode: FileMode.append);
    file.writeAsStringSync("\"ISI MAX (ms):\", ${pvt_data.ISI_Max}  \r\n",
        mode: FileMode.append);
    file.writeAsStringSync(
        "\"TRIAL LENGTH (s):\", ${pvt_data.Trial_length} \r\n",
        mode: FileMode.append);
    file.writeAsStringSync("\"TASK:\", \"V\" \r\n", mode: FileMode.append);
    file.writeAsStringSync("\"HAND: \",\"R\" \r\n", mode: FileMode.append);
    file.writeAsStringSync("\"PVT S/N:\", ${pvt_data.PVT_Serial_Num}\r\n",
        mode: FileMode.append);

    int i;
    for (i = 0; i < pvt_data.reactionTimes.length; i++) {
      double mytime = pvt_data.stimulationTimes[i] / 1000;
      print("${pvt_data.reactionTimes[i]}," + mytime.toStringAsFixed(1));
      file.writeAsStringSync(
          "${pvt_data.reactionTimes[i]}," + mytime.toStringAsFixed(1) + "\r\n",
          mode: FileMode.append);
    }
    file.writeAsStringSync("0, 0\r\n", mode: FileMode.append);
  } catch (e) {
    print("error writing file");
  }
  final path = await _localPath;
  List<String> myattachment = ['$path/$pvt_filename'];

  final Email email = Email(
    body:
        "Attached is the PVT file automatically sent from the Mobile PVT Application,  version:" +
            packageInfo.version,
    //INCLUDE APP VERSION NUMBER IN EMAIL BODY
    subject: "mobile_pvt: PVT file, Device ID = $androidId ",
    recipients: [
      pvt_data.Main_Email,
      "tomk@ambulatory-monitoring.com",
      "marty@bruner-consulting.com"
    ],
    attachmentPaths: myattachment,
    isHTML: false,
  );
  try {
    await FlutterEmailSender.send(email);
    print('success');
  } catch (error) {
    print(error.toString());
  }
  // Write the file
  return file;
}
