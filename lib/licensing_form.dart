import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pvt/register_form.dart';

import 'Copy_protection.dart';
import 'main.dart';

class LicForm extends StatefulWidget {
  const LicForm({Key? key, required String title}) : super(key: key);

  @override
  _LicFormState createState() => _LicFormState();
}

class _LicFormState extends State<LicForm> {
  final Activate_Controller = TextEditingController();

  @override
  void initState() {
    setState(() {
      Activate_Controller.text = "";
    });
    return super.initState();
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
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 75,
              // child: Image.asset(
              //'assets/images/splash_trans.png',  //generic pvt
              // 'assets/images/ami_206red.png', //AMI
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
                "App Locked: Obtain activation code via e-mail from AMI by registering device below.",
                //"Unlocked:  License activated upon first PVT Test performed.",
                //"Activated: License expires on xx/xx/20xx.",
                //"Expired:  Obtain new activation code from AMI via button below.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                //style: Theme.of(context).textTheme.subtitle1,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 24, 0, 12),
                    child: Text(
                      "Enter registration code from e-mail",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      //style: Theme.of(context).textTheme.subtitle1,
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
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
                        copyProtectedState = await readCopyProtection();
                        String message = "Unable to perform operation";
                        switch (copyProtectedState) {
                          case 0:
                            if (await UnLock(Activate_Controller.text)) {
                              String message = "License Unlocked";
                            }
                            break;
                          case 2:
                            if (await ExtendLicense(Activate_Controller.text)) {
                              String message = "License Extended";
                            }
                            break;
                          case 3:
                            if (await RenewLicense(Activate_Controller.text)) {
                              String message = "License Renewed";
                            }
                            break;
                        }
                        await _showMyDialog(message);
                      },
                    ),
                  ],
                ),
              ),
            ),
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
          title: const Text('AlertDialog Title'),
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
}
