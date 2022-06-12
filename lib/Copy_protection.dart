import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:platform_device_id/platform_device_id.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'main.dart';

String deviceID = "Blah";
String? _deviceId; // = "Starting";
bool TrialFileFound = false;
bool TrialActive = false;
bool LicenseFileFound = false;
bool LicenseActive = false;
BigInt deviceIdNum = BigInt.from(0);
bool FileFound = false;
String ucodedID = "Blank";
String CodedId = "";
bool validLicenseFound = false;
BigInt nextIDint = BigInt.from(0);
String nextIDstring = "";

// seperator
BigInt androidId = BigInt.from(0);
BigInt licenseId = BigInt.from(0);
BigInt nextLicenseId = BigInt.from(0);
BigInt licenseCode = BigInt.from(0);
BigInt expirationDate = BigInt.from(-1);

// gets the android ID. First attempts to read from android.Id
// if that file does not exist, create file.
Future<BigInt> getAndroidId() async {
  BigInt Id = BigInt.from(0);
  // get external directory path
  final path = (await getExternalStorageDirectory())!.path;
  // try open android.Id
  final myFile = File('$path/android.Id');
  final doesExist = await myFile.exists();
  if (doesExist == true) {
    // if exists, read value from file
    final readContents = await myFile.readAsString();
    print('contents of file: $readContents');
    Id = BigInt.parse(readContents, radix: 10);
  } else {
    // else generate an Id and write to file
    Random random = new Random();
    Id = BigInt.from(random.nextInt(4294967295));
    myFile.writeAsString(Id.toString());
  }
  return Id;
}

Future<BigInt> getLicenseId() async {
  //Get internal documents directory
  final path = (await getApplicationDocumentsDirectory())!.path;
  BigInt licenseNum = BigInt.from(0);

  // See fi license file exists
  final licenseFile = File('$path/license.id');
  final doesExist = await licenseFile.exists();
  if (doesExist == true) {
    // if exists, read value from file
    final readContents = await licenseFile.readAsString();
    print('contents of file: $readContents');
    licenseNum = BigInt.parse(readContents, radix: 10);
  } else {
    // else generate an Id and write to file
    Random random = new Random();
    licenseNum = BigInt.from(random.nextInt(4294967295)).toUnsigned(32);
    print("license num $licenseNum");
    print(encodeID(licenseNum));

    // write to a file
    licenseFile.writeAsString(licenseNum.toString());
  }

  return licenseNum;
}
/*
copy protection states
state 0: no ID.txt -> Create ID trial only
state 1: ID, but no activation code (ID.bin is available)
state 2: ID And activation code.   license is active.  When switched to state 2,
nextID file is written with next ID.
state 3: License expired.  NextID file is moved to ID.txt.


 */

Future generateID() async {}

BigInt getEndDate(String endDate) {
  return BigInt.parse(endDate, radix: 10);
}

Future writeIDFile(BigInt ID) async {
  final path = (await getExternalStorageDirectory())!.path;
  print('$path/AndroidID.bin');
  final myFile = File('$path/AndroidID.bin');
  myFile.writeAsString(ID.toString());
}

Future writeNextIDFile(BigInt ID) async {
  final path = (await getExternalStorageDirectory())!.path;
  final myFile = File('$path/nextAndroidID.bin');
  myFile.writeAsString(ID.toString());
}

Future deleteNextIDFile() async {
  try {
    final path = (await getExternalStorageDirectory())!.path;
    final file = await File('$path/nextAndroidID.bin');
    await file.delete();
  } catch (e) {}
}

Future<int> getCopyProtectionState() async {
  return 0;
}

/*
returns state

1.  check to see if AndroidID exists.
2.  If it doesn't exist, generate new ID and write file return state 1
3.  If it exists, check for coded id file
4.  If it doesn't exist return state 1
5.  If it does exist, read license date
6.  Check to see if license is expired.
7.  If not expired, return 2, system is operational
8.  If license has expired, check for nextID.bin
9.  If it exists, read ID and rewrite it to AndroidID.bin return state 1
10. If it doesn't exist, generate new ID and write file return state 1

 */
Future<int> readCopyProtection() async {
  // 1.  check to see if Android.ID exists. If it does not, then
  //     generate one.

  androidId = await getAndroidId();

  // Look for a license ID  If one isn't found then generate one
  licenseId = await getLicenseId();
  print("license ID = $licenseId");

  // see if we have an ecodedLicense.bin file.  If we do,
  // Read the file to determine whether or not we have a
  // Valid license

  final encodedLicense = encodeID(licenseId).toString();
  print("encoded license: $encodedLicense");
  // await UnLock(encodedLicense);
  final licenseExists = await readLicenseFile(encodedLicense);
  if (!licenseExists) {
    return 0; // State 0 locked

  } else {
    // if expiration date is zero, we are unlocked, but not activated
    if (expirationDate.compareTo(BigInt.from(0)) == 0) {
      return 1; // Unlocked but not activated

    } else {
      // check to see if we are past the expiration date.

      final currentDate =
          BigInt.from((DateTime.now().millisecondsSinceEpoch / 1000).round());
      if (expirationDate.compareTo(currentDate) == 1) {
        return 3; // Expired License

      } else {
        return 2; // Normal License
      }
    }
  }

/*
  final deviceExists = await readDeviceID();

  //3.  If it exists, check for coded id file (license file)
  if (deviceExists) {
    deviceID = deviceIdNum.toString();
    final licenseExists =
        await readLicenseFile(encodeID(deviceIdNum).toString());
    //5.  If it does exist, read license date
    if (licenseExists) {
      final currentDate =
          BigInt.from((DateTime.now().millisecondsSinceEpoch / 1000).round());
      //7.  If not expired, return 2, system is operational
      if (expirationDate < currentDate) {
        return 2;
      } else {
        // lets see if we have a nextID file

        final nextIDFileExists = await readNextDeviceID();

        //9.  If it exists, read ID and rewrite it to AndroidID.bin return state 1
        if (nextIDFileExists) {
          //delete next id file
          deleteNextIDFile();

          // use next id file as new ID field.
          writeIDFile(nextIDint);
          return 1;
        } else {
          // Else generate a new ID and write it to a file.
          deviceIdNum = await generateDeviceID();
          await writeIDFile(deviceIdNum);
          return 1;
        }
      }
    }
  } else {
    //2.  If it doesn't exist, generate new ID and write file return state 1
    final myId = await generateDeviceID();
    await writeIDFile(myId);
    return 1;
  }
  //validLicenseFound = await find_Licensefile();
  */

  return 0;
}

BigInt encodeID(BigInt ID) {
  final encodedId =
      (~(ID + BigInt.from(0x881963)) - BigInt.from(0x881963)).toUnsigned(32);
  return encodedId;
}

Future<int> deleteIDFile() async {
  try {
    final path = (await getExternalStorageDirectory())!.path;
    final file = await File('$path/AndroidID.bin');

    await file.delete();
  } catch (e) {
    return 0;
  }
  return 0;
}

/*Future<int> readCopyProtection() async {
  final deviceExists = await readDeviceID();
  if (deviceExists) {
    deviceID = deviceIdNum.toString();
  } else {
    final myId = await generateDeviceID();
    await writeIDFile(myId);
    return 1;
  }
  validLicenseFound = await find_Licensefile();
  return 0;
}*/

/*
Generates a license file using the ID.  The expiration date
will either be a year from now or a year added to the current
expiration date.
 */
Future generateLicense(String encodedLicenseNum) async {
  print("Unlocking");
  BigInt newLicenseExpiration = BigInt.from(0);
  final currentDate =
      BigInt.from((DateTime.now().millisecondsSinceEpoch / 1000).round());

  // Check to see if expiration date has passed.  If so than one year from today
  newLicenseExpiration = BigInt.from(0);

  // Write this new file
  final path = (await getApplicationDocumentsDirectory())!.path;
  final file = encodedLicenseNum;
  print('$path/$file.bin');
  final content = await File('$path/$file.bin');
  content.writeAsString('$newLicenseExpiration');
  print("Finished");
}

Future ActivateLicense() async {
  print("Activating License");
  BigInt newLicenseExpiration = BigInt.from(0);
  final currentDate =
      BigInt.from((DateTime.now().millisecondsSinceEpoch / 1000).round());

  // Check to see if expiration date has passed.  If so than one year from today
  // otherwise, add one year to the current license
  newLicenseExpiration = currentDate + BigInt.from((365 * 24 * 60 * 60));

  // Write this new file
  final path = (await getApplicationDocumentsDirectory())!.path;
  final file = encodeID(licenseId).toString();
  print('$path/$file.bin');
  final content = await File('$path/$file.bin');
  content.writeAsString('$newLicenseExpiration');
  print("Generate next license");
  getNextLicenseID();
}

/*
readLicenseFile
Will read license file and set expiration date based upon the
value read.
 */
Future<bool> readLicenseFile(String ID) async {
  final path = (await getApplicationDocumentsDirectory())!.path;
  final file = ID;
  print('$path/$file.bin');
  final content = await File('$path/$file.bin');
  final doesExist = await content.exists();
  if (doesExist == true) {
    print("this file exists");

    final readContents = await content.readAsString();
    print('contents of file: $readContents');
    final _expirationDate = BigInt.parse(readContents, radix: 10);

    expirationDate = _expirationDate;
    print("date converted = $expirationDate");
    return true;
  } else {
    expirationDate = BigInt.from(-1);
    return false;
  }
}

Future<BigInt> generateDeviceID() async {
  BigInt mynum;
  Random random = new Random();
  mynum = BigInt.from(random.nextInt(4294967295));
  return mynum;
  //mynum = BigInt.parse(_deviceId!, radix: 16).toUnsigned(32);
}

Future<bool> readDeviceID() async {
  final path = (await getExternalStorageDirectory())!.path;
  print('$path/AndroidID.bin');
  final content = await File('$path/AndroidID.bin');
  final doesExist = await content.exists();
  if (doesExist == true) {
    print("this file exists");
    final readContents = await content.readAsString();
    print('contents of file: $readContents');
    deviceIdNum = BigInt.parse(readContents, radix: 10);

    return true;
  } else {
    return false;
  }
}

Future generateNextLicenseID() async {
  final path = (await getApplicationDocumentsDirectory())!.path;
  print('$path/nextLicense.id');
  final content = await File('$path/nextLicense.id');
  final doesExist = await content.exists();
  if (doesExist == true) {
    await content.delete();
  }

  // else generate an Id and write to file
  Random random = new Random();
  nextLicenseId = BigInt.from(random.nextInt(4294967295)).toUnsigned(32);
  print("Next license num $nextLicenseId");
  print(encodeID(nextLicenseId));

  // write to a file
  content.writeAsString(nextLicenseId.toString());
}

Future<bool> getNextLicenseID() async {
  final path = (await getApplicationDocumentsDirectory())!.path;
  print('$path/nextLicense.id');
  final content = await File('$path/nextLicense.id');
  final doesExist = await content.exists();
  if (doesExist == true) {
    print("this file exists");
    final readContents = await content.readAsString();
    print('contents of file: $readContents');

    nextLicenseId = BigInt.parse(readContents, radix: 10);

    return true;
  }
  return false;
}

Future<bool> setup_deviceID() async {
  //String? _deviceId;
  BigInt mynum = BigInt.from(0);

  String deviceName;
  String deviceVersion;
  String identifier;
  // final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  /* try {
    String? deviceID = await PlatformDeviceId.getDeviceId;
    print("DeviceID prior to peppering $deviceID");
    ucodedID = deviceID!;
  } on PlatformException {
    print('Failed to get platform version');
  }
  try {
    _deviceId = await PlatformDeviceId.getDeviceId;
    print("_deviceId prior to peppering $_deviceId");
  } on PlatformException {
    _deviceId = '0123456789abcdef';
    return false;
  }*/

  mynum =
      (~(mynum + BigInt.from(0x881963)) - BigInt.from(0x881963)).toUnsigned(32);
  deviceID = mynum.toString();

  print("Unencoded Id $_deviceId");
  print("Encoded ID $deviceID");
  //print("My num $mynum");
  return true;
}

Future<bool> find_Licensefile() async {
  final path = (await getApplicationDocumentsDirectory())!.path;
  final file = deviceID;
  final deviceId = _deviceId;
  print('$path/$file.bin');
  final content = await File('$path/$file.bin');
  final doesExist = await content.exists();

  if (doesExist == true) {
    print("this file exists");
    print("deviceID $deviceId");
    final readContents = await content.readAsString();
    print('contents of file: $readContents');
    var trial_date_ms = BigInt.parse(readContents, radix: 10);
    print("date converted = $trial_date_ms");
    // Delete File for testing purposes
    //final delete = await File('$path/$file.bin').delete();

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
      body: 'Device ID: $deviceId, Name :, Organization:, Phone Number:',
      subject: "Mobile PVT Registration",
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
}

Future<bool> UnLock(String activateCode) async {
  final codenum = BigInt.parse(activateCode, radix: 10);
  print(codenum);
  print(encodeID(licenseId));
  if (codenum == encodeID(licenseId)) {
    print("successfully registered");
    generateLicense(activateCode);
    // Generate next ID
    /*final nextID = await generateDeviceID();
    writeNextIDFile(nextID);*/
    return true;
  } else {
    print("Error");
    return false;
  }
}

/* This currently does not work.  We need to write the code
That actaully extends the license from the current date.

We also need to transfer the extended license code to the
license code.
 */
Future<bool> ExtendLicense(String activateCode) async {
  final codenum = BigInt.parse(activateCode, radix: 10);
  bool exists = await getNextLicenseID();
  if (!exists) {
    return false;
  }
  print(codenum);
  print(encodeID(nextLicenseId));
  if (codenum == encodeID(nextLicenseId)) {
    print("successfully registered");
    generateLicense(activateCode);
    getNextLicenseID();
    return true;
  } else {
    print("Error");
    return false;
  }
}

/*this code is not complete
We also need to transfer the extended license code to the
license code.
 */
Future<bool> RenewLicense(String activateCode) async {
  final codenum = BigInt.parse(activateCode, radix: 10);
  bool exists = await getNextLicenseID();
  if (!exists) {
    return false;
  }
  print(codenum);
  print(encodeID(nextLicenseId));
  if (codenum == encodeID(nextLicenseId)) {
    print("successfully registered");
    generateLicense(activateCode);
    getNextLicenseID();
    // Generate next ID
    /*final nextID = await generateDeviceID();
    writeNextIDFile(nextID);*/
    return true;
  } else {
    print("Error");
    return false;
  }
}
//Future ActivateLicense() {}

Future sendRegistrationEmail(String name, String organization) async {
  final Email email = Email(
    body: 'Device ID: $deviceIdNum, Name :$name, Organization:$organization',
    subject: "Mobile PVT Registration",
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
}

Future<File> get writeLicenseFile async {
  final path = (await getExternalStorageDirectory())!.path;
  final file = deviceID;
  print('$path/$file.bin');
  return File('$path/$file.bin');
}
