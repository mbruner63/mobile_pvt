import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Resource/MyColors.dart';
import 'package:mobile_pvt/register_form.dart';

import 'Copy_protection.dart';
import 'main.dart';

String _message = "";
int state = 0;
int myint = 0;

class LicForm extends StatefulWidget {
  const LicForm({Key? key, required String title}) : super(key: key);

  @override
  _LicFormState createState() => _LicFormState();
}

class _LicFormState extends State<LicForm> {
  final Activate_Controller = TextEditingController();
  int shared_mem = 0;
  String createMessage(int state) {
    String message = "";
    switch (state) {
      case 0:
        message =
            "App Locked: Obtain activation code via e-mail from AMI by registering device below.";
        break;
      case 1:
        message = "Unlocked:  PVT is ready to use";
        break;
      /*case 2:
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(
            (expirationDate * BigInt.from(1000)).toInt());
        message = "Activated: License expires on " + date.toString();
        break;
      case 3:
        message =
            "Expired:  Obtain new activation code from AMI via button below.";
      //"Unlocked:  License activated upon first PVT Test performed.",
      //"Activated: License expires on xx/xx/20xx.",
      //"Expired:  Obtain new activation code from AMI via button below.",
*/
    }

    return message;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      Activate_Controller.text = "";
      _message = createMessage(state);
    });
  }

  @override
  void dispose() {
    Activate_Controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PVT - App Licensing'),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "v " + packageInfo.version,
                  style: TextStyle(fontSize: 20),
                ),
              ],
              // padding: const EdgeInsets.all(4.0),
              // child: Container(
              //   width: 75,
              //  child: Image.asset(
              //'assets/image/splash_trans206.png', //generic pvt
              //  'assets/images/ami_test206red.png', //AMI logo
              // 'assets/images/CliniLogo_Lt.png', //CLINILABS
              // ),
            ),
          ),
        ],
        //backgroundColor: Colors.grey.shade400,
      ),
      //backgroundColor: Theme.of(context).backgroundColor,
      body: SizedBox.expand(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 36, 12, 10),
              child: Text(
                "License Status:",

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                //style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
//Text for states of licensing:
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 12),
              child: Text(
                _message,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                //style: Theme.of(context).textTheme.subtitle1,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 18),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 12, horizontal: 8),
                    //   child: Text(
                    //     "Obtain registration code via e-mail",
                    //     style: TextStyle(
                    //         fontSize: 18, fontWeight: FontWeight.bold),
                    //     //style: Theme.of(context).textTheme.subtitle1,
                    //   ),
                    // ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                          // backgroundColor: MaterialStateProperty.all<Color>(
                          //     Colors.blue.shade900),
                          ),
                      icon: Icon(Icons.assignment, size: 30),
                      label: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Register Device',
                            style: TextStyle(fontSize: 22)),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterForm(
                                    title: 'PVT - Register Device')));
                      },
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
                    child: Text(
                      "Enter registration code from e-mail",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: TextField(
                      controller: Activate_Controller,
                      cursorColor: Colors.grey,
                      cursorHeight: 30,
                      maxLines: 1,
                      maxLength: 20,
                      style: TextStyle(fontWeight: FontWeight.normal),
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      onChanged: (text) {},
                    ),
                  ),
                ],
              ),
            ), // User Notes

            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      style: ButtonStyle(
                          // backgroundColor: MaterialStateProperty.all<Color>(
                          //     Colors.blue.shade900),
                          ),
                      icon: Icon(Icons.lock_open_rounded, size: 30),
                      label: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Unlock License',
                            style: TextStyle(fontSize: 22)),
                      ),
                      onPressed: () async {
                        bool result = false;
                        //Attempt to activation controller using code;
                        /*if (Activate_Controller.text == "ZZZ") {
                          await _areYouSure();
                          if (shared_mem == 1) {
                            destroy_licenses();
                          }
                          print(shared_mem);
                        } else*/
                        {
                          String message = "Unable to perform operation";
                          if (await UnLock(Activate_Controller.text)) {
                            message = "License Unlocked.";
                          } else {
                            message = "Incorrect Code";
                          }
                          /*switch (copyProtectedState) {
                            case 0:
                              if (await UnLock(Activate_Controller.text)) {
                                message =
                                    "License Unlocked.  Start a PVT test to activate";
                              } else {
                                message = "Incorrect Code";
                              }
                              break;
                            case 2:
                              if (await ExtendLicense(
                                  Activate_Controller.text)) {
                                message = "License Extended";
                              } else {
                                message = "Incorrect Code";
                              }
                              break;
                            case 3:
                              if (await RenewLicense(
                                  Activate_Controller.text)) {
                                message = "License Renewed";
                              } else {
                                message = "Incorrect Code";
                              }
                              break;
                          }*/
                          await _showMyDialog(message);
                          copyProtectedState = await readCopyProtection();
                          setState(() {
                            _message = createMessage(copyProtectedState);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
/*
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 36, 18, 4),
              child: Text(
                "Reset App to default state",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.red.shade900),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 4),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      style: ButtonStyle(),
                      icon: Icon(
                        Icons.disabled_by_default_outlined,
                        size: 25,
                        color: Colors.red.shade900,
                      ),
                      label: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Reset License',
                            style: TextStyle(
                                fontSize: 18, color: Colors.red.shade900)),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            */
          ],
        ),
      ),

      // body: SizedBox.expand(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Container(
      //         constraints: BoxConstraints(
      //             minWidth: (MediaQuery.of(context).size.width - 10) / 2),
      //         // width: double.maxFinite,
      //         height: 90,
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: ElevatedButton.icon(
      //             style: ButtonStyle(),
      //             icon: Icon(Icons.assignment, size: 50),
      //             label: Text('Register Device via e-mail',
      //                 style: TextStyle(fontSize: 24)),
      //             //allows user to send device id to ami so they send activation code
      //             onPressed: () {
      //               Navigator.pushReplacement(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) =>
      //                           RegisterForm(title: 'PVT - Register Device')));
      //             },
      //           ),
      //         ),
      //       ),
      //
      //       Container(
      //         constraints: BoxConstraints(
      //             minWidth: (MediaQuery.of(context).size.width - 10) / 2),
      //         //width: double.maxFinite,
      //         height: 90,
      //         child: Padding(
      //           padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
      //           child: Text(
      //             "Enter Registration Code from e-mail",
      //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //             // style: Theme.of(context).textTheme.headline6,
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      //         child: TextField(
      //           cursorColor: Colors.grey,
      //           cursorHeight: 30,
      //           maxLines: 1,
      //           maxLength: 15,
      //           style: TextStyle(fontWeight: FontWeight.normal),
      //           decoration: const InputDecoration(
      //             focusedBorder: OutlineInputBorder(
      //               borderSide: const BorderSide(color: Colors.grey, width: 2),
      //               borderRadius: const BorderRadius.all(Radius.circular(16)),
      //             ),
      //             border: OutlineInputBorder(
      //               borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      //             ),
      //           ),
      //           onChanged: (text) {},
      //         ),
      //       ),
      //       Container(
      //         constraints: BoxConstraints(
      //             minWidth: (MediaQuery.of(context).size.width - 10) / 2),
      //         //width: double.maxFinite,
      //         height: 90,
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: ElevatedButton.icon(
      //             icon: Icon(Icons.lock_open_rounded, size: 50),
      //             label:
      //                 Text('Activate License', style: TextStyle(fontSize: 24)),
      //             //enter code that tom sends to activate license for full function use
      //             onPressed: () {},
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Future<void> _showMyDialog(String message) async {
    String myMessage = "";
    myMessage = message;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('License Status'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(myMessage),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _areYouSure() async {
    String myMessage =
        "Are you sure you want to clear your license status?  This will lock the app until re-registered";
    shared_mem = 0;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear License Status'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(myMessage),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Clear'),
              onPressed: () {
                Navigator.of(context).pop();
                shared_mem = 1;
              },
            ),
            TextButton(
              child: const Text('Abort'),
              onPressed: () {
                Navigator.of(context).pop();
                shared_mem = 0;
              },
            ),
          ],
        );
      },
    );
  }
}
