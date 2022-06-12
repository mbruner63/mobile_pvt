import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pvt/licensing_form.dart';
import 'package:mobile_pvt/main_menu.dart';
import 'package:mobile_pvt/config_page.dart';

class FormPage extends StatefulWidget {
  FormPage({Key? key, required this.title}) : super(key: key) {}
  final String title;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // String name, email, phone;

  //TextController to read text entered in text field
  // TextEditingController password = TextEditingController();
  String password = 'amipvt'; //'69420';
  TextEditingController confirmpassword = TextEditingController();

  //final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: const Text(
            'PVT - Unlock Settings',
            // style: TextStyle(fontSize: 20),
          ),
        ),
        // title: const Text('PVT Session in Progress'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 75,
              // child: Image.asset(
              //   'assets/images/icon.png',
              //   'assets/images/CliniLogo_Lt.png', //CLINILABS
              // ),
            ),
          ),
        ],
        //backgroundColor: Colors.grey.shade800,
      ),
      // appBar: AppBar(
      //   title: const Text('PVT - Unlock Settings'),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(4.0),
      //       child: Container(
      //         width: 75,
      //         child: Image.asset(
      //           'assets/images/CliniLogo_Lt.png',
      //         ),
      //       ),
      //     ),
      //   ],
      //   //backgroundColor: Colors.grey.shade400,
      // ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: Text(
                    "Enter Password to Unlock Settings",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 20,
                      //  color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: (MediaQuery.of(context).size.width) / 1.512),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 18,
                        //  color: Colors.white,
                      ),
                      autofocus: true,
                      //enabled: true,
                      // decoration: InputDecoration(
                      //   fillColor: Colors.grey[400],
                      // ),
                      initialValue: null,
                      controller: confirmpassword,
                      obscureText: true,
                      //keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }

                        if (password != confirmpassword.text) {
                          confirmpassword.text = '';
                          return "Password does not match, re-enter";
                        }
                        if (password == confirmpassword.text) {
                          //confirmpassword.text = null;

                          // if (_formkey.currentState.validate()) {
                          //_formkey.currentState.initState();
                          //FormField.initialValue;
                          _formKey?.currentState?.reset();
                          confirmpassword.text = '';
                          onPressed:
                          () {};
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ConfigPage(
                          //             title: 'PVT - Configure Session')));

                          print("successful");

                          // return;
                        }

                        //return "Success";
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 65,
                  child: ElevatedButton.icon(
                      style: ButtonStyle(),
                      icon: Icon(Icons.lock_open_rounded, size: 30),
                      label: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      //color: Colors.redAccent,
                      onPressed: () {
                        if (_formKey.currentState!.validate())
                        //currentState.validate(_formKey);

                        // if (password == confirmpassword.text) {
                        //   //confirmpassword.text = null;
                        //
                        //   // if (_formkey.currentState.validate()) {
                        //   //_formkey.currentState.initState();
                        //   //FormField.initialValue;
                        //   _formKey?.currentState?.reset();
                        //   confirmpassword.text = '';
                        if (settingsLicenseSelect == 0) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfigPage(
                                      title: 'PVT - Configure Session')));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      //  ConfigPage(title: 'PVT - Configure Session')));
                                      LicForm(title: 'PVT - App Licensing')));
                        }
                        //
                        //   print("successful");
                        //
                        //   return;
                        // } else {
                        confirmpassword.text = '';
                        // print("unsuccessful");
                      }
                      //},
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
