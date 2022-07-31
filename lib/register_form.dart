import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pvt/main_menu.dart';

import 'Copy_protection.dart';
import 'licensing_form.dart';
import 'main.dart';
import 'mobile_pvt_disclaimer.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key, required this.title}) : super(key: key) {}

  final String title;

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  _RegisterFormState() {}
  final Name_Controller = TextEditingController();
  final Organization_Controller = TextEditingController();

  @override
  void initState() {
    setState(() {
      Name_Controller.text = "";
      Organization_Controller.text = "";
    });
    return super.initState();
  }

  @override
  void dispose() {
    Name_Controller.dispose();
    Organization_Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: const Text(
            'PVT - Register Device',
          ),
        ),
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
      ),
      body: SizedBox.expand(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: Text(
                      "Name",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      //style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    child: TextField(
                      controller: Name_Controller,
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
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: Text(
                      "Organization",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      // style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    child: TextField(
                      controller: Organization_Controller,
                      cursorColor: Colors.grey,
                      cursorHeight: 30,
                      maxLines: 1,
                      maxLength: 30,
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
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                      onChanged: (text) {},
                    ),
                  ),
                  Padding(
                    padding: //SET PADDING fromLTRB
                        const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton.icon(
                            style: ButtonStyle(),
                            icon: Icon(Icons.email, size: 30),
                            label: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('Request code via e-mail',
                                  style: TextStyle(fontSize: 22)),
                            ),
                            onPressed: () {
                              sendRegistrationEmail(Name_Controller.text,
                                  Organization_Controller.text);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          //  ConfigPage(title: 'PVT - Configure Session')));
                                          LicForm(
                                              title: 'PVT - App Licensing')));
                            },
                          ),
                        ],
                      ),
                    ),
                  ), //END OF EMAIL AREA
                ],
              ),
            ), // User Notes
          ],
        ),
      ),
    );
  }
}
