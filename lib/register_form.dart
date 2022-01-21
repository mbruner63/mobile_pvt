import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pvt/main_menu.dart';

import 'mobile_pvt_disclaimer.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key, required this.title}) : super(key: key) {}

  final String title;

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  _RegisterFormState() {}

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
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 75,
              child: Image.asset(
                //   'assets/images/icon.png',
                'assets/images/CliniLogo_Lt.png', //CLINILABS
              ),
            ),
          ),
        ],
      ),
      body: Center(
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
                  Column(
                    children: [
                      Padding(
                        //right now can only enter email, does not send nor validate
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 8),
                        child: Text(
                          "e-mail",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    child: TextField(
                      cursorColor: Colors.grey,
                      cursorHeight: 30,
                      maxLines: 1,
                      // maxLength: 50,
                      style: TextStyle(fontWeight: FontWeight.normal),
                      //style: Theme.of(context).textTheme.headline6,
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
                              child: Text('Send code to e-mail',
                                  style: TextStyle(fontSize: 22)),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ), //END OF EMAIL AREA

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
                    child: Text(
                      "Enter Registration Code from e-mail",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      // style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: TextField(
                      cursorColor: Colors.grey,
                      cursorHeight: 30,
                      maxLines: 1,
                      maxLength: 15,
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
                ],
              ),
            ), // User Notes

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      style: ButtonStyle(),
                      icon: Icon(Icons.check, size: 30),
                      label: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Register', style: TextStyle(fontSize: 22)),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MainMenu(title: 'Main Menu')));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
