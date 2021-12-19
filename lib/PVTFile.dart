import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_pvt/rating_page.dart';
import 'package:mobile_pvt/session_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'AfterRating.dart';
import 'PVTData.dart';

Future<String?> get _localPath async {
  WidgetsFlutterBinding.ensureInitialized();
  //final directory = await getApplicationDocumentsDirectory();
  final Directory? directory = await getExternalStorageDirectory();

  return directory?.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  print('$path/testfile.pvt');
  return File('$path/testfile.pvt');
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
    file.writeAsStringSync("\n\"PVT DATA\" \n");
    file.writeAsStringSync("\"STUDY: \", \"$pvt_data.Study\" \n",
        mode: FileMode.append);
    file.writeAsStringSync(
        "\"SLEEPY PRE, POST TRIAL: \",$pvt_data.Before_Rating,$pvt_data.After_Rating\n",
        mode: FileMode.append);
    file.writeAsStringSync("\"E. INITIALS:\", \"$pvt_data.E_Initials\"\n",
        mode: FileMode.append);
    file.writeAsStringSync("\"S. INITIALS:\", \"$pvt_data.S_Initials\"\n",
        mode: FileMode.append);
    file.writeAsStringSync("\"S. ID NUMBER:\", \"$pvt_data.S_ID\"\n",
        mode: FileMode.append);
    file.writeAsStringSync("\"TRIAL NUMBER:\", $pvt_data.Trial_Number \n",
        mode: FileMode.append);
    file.writeAsStringSync("\"TRIAL DATE:\", \"$pvt_data.Trial_Date\"\n",
        mode: FileMode.append);
    file.writeAsStringSync("\"TRIAL TIME:\", \"$pvt_data.Trial_Time\" \n",
        mode: FileMode.append);
    file.writeAsStringSync("\"ISI MIN (ms):\", $pvt_data.ISI_Min  \n",
        mode: FileMode.append);
    file.writeAsStringSync("\"ISI MAX (ms):\", $pvt_data.ISI_Max  \n",
        mode: FileMode.append);
    file.writeAsStringSync("\"TRIAL LENGTH (s):\", $pvt_data.Trial_length \n",
        mode: FileMode.append);
    file.writeAsStringSync("\"TASK:\", \"H\" \n", mode: FileMode.append);
    file.writeAsStringSync("\"HAND: \",\"R\" \n", mode: FileMode.append);
    file.writeAsStringSync("\"PVT S/N:\", $pvt_data.PVT_Serial_Num\n",
        mode: FileMode.append);

    int i;
    for (i = 0; i < pvt_data.reactionTimes.length; i++) {
      double mytime = pvt_data.stimulationTimes[i] / 1000;
      file.writeAsStringSync(
          "${pvt_data.reactionTimes[i]}," + mytime.toStringAsFixed(1) + "\n",
          mode: FileMode.append);
    }
    file.writeAsStringSync("0, 0\n", mode: FileMode.append);
  } catch (e) {
    print("error writing file");
  }
  final path = await _localPath;
  List<String> myattachment = ['$path/testfile.pvt'];

  final Email email = Email(
    body: "Attached is the PVT file automatically sent from mobile_pvt",
    subject: "mobile_pvt: PVT file",
    recipients: [
      "marty@bruner-consulting.com",
      "tomk@ambulatory-monitoring.com",
      pvt_data.Main_Email
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
