import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pvt/main_menu.dart';
//import 'package:toggle_switch/toggle_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import '/main.dart';
import 'PVTData.dart';
import 'main.dart';

List<int> sessionTimes = [60, 180, 300, 600];

class ConfigPage extends StatefulWidget {
  ConfigPage({Key? key, required this.title}) : super(key: key) {}

  final String title;

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  _ConfigPageState() {}
  int i = 5;
  List<bool> isSelected = [true, false, false, false];
  final EI_Controller = TextEditingController();
  final SID_Controller = TextEditingController();
  final SI_Controller = TextEditingController();
  final Email_Controller = TextEditingController();

  SharedPreferences? preferences;

  @override
  void initState() {
    initializePreference().whenComplete(() {
      setState(() {
        EI_Controller.text = pvt_data.E_Initials;
        SI_Controller.text = pvt_data.S_Initials;
        SID_Controller.text = pvt_data.S_ID;
        Email_Controller.text = pvt_data.Main_Email;
      });
    });
    return super.initState();
  }

  @override
  /*Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }*/

  @override
  void dispose() {
    EI_Controller.dispose();
    SID_Controller.dispose();
    SI_Controller.dispose();
    Email_Controller.dispose();
    super.dispose();
  }

  //Jordan's playing

  Future<void> initializePreference() async {
    this.preferences = await SharedPreferences.getInstance();
    pvt_data.E_Initials = this.preferences?.getString("einitials") ?? "jkb";
    pvt_data.S_Initials = this.preferences?.getString("sinitials") ?? "mlb";
    pvt_data.S_ID = this.preferences?.getString("sid") ?? "0001";
    pvt_data.Main_Email =
        this.preferences?.getString("email") ?? "marty@bruner-consulting.com";
  }

  void _setPreference() async {
    setState(() {
      this.preferences?.setString("einitials", pvt_data.E_Initials);
      this.preferences?.setString("sinitials", pvt_data.S_Initials);
      this.preferences?.setString("sid", pvt_data.S_ID);
      this.preferences?.setString("email", pvt_data.Main_Email);
    });
  }

  //Jordan's playing done

  @override
  Widget build(BuildContext context) {
    int sessionLengthIndex = 0;
    switch (sessionLengthIndex) {
      case 60:
        sessionLengthIndex = 0;
        break;
      case 180:
        sessionLengthIndex = 1;
        break;
      case 300:
        sessionLengthIndex = 2;
        break;
      case 600:
        sessionLengthIndex = 3;
        break;
      default:
        sessionLengthIndex = 0;
        break;
    }
    switch (sessionTime) {
    }
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: const Text(
            'PVT - Configure Session',
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
              // 'assets/images/splash_trans.png', //generic pvt
              // 'assets/images/CliniLogo_Lt.png', //CLINILABS
              // ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 0), //.all(4),
                      child: Text(
                        'Session length',
                        //style: Theme.of(context).textTheme.subtitle1,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              //      color:
                              // Colors.grey.shade800,//unselected bg color
                              // border: Border.all(width: 1),
                              borderRadius: const BorderRadius.all(
                                (const Radius.circular(8)),
                              ),
                            ),
                            //border: BorderRadius.circular(50),
                            // color: Colors.grey.shade600, //unselected bg color
                            child: ToggleButtons(
                              isSelected: isSelected,
                              borderRadius: BorderRadius.circular(16),
                              //
                              // color: Colors.grey.shade400, //unselected text
                              // disabledColor: Colors.grey,
                              // selectedColor: Colors.white, //selected text
                              // fillColor:
                              //     Colors.blue.shade900, //selected bg color
                              borderWidth: 2,
                              //renderBorder: false,
                              //selectedBorderColor: Colors.blue.shade900,
                              onPressed: (int newIndex) {
                                setState(() {
                                  for (int index = 0;
                                      index < isSelected.length;
                                      index++) {
                                    if (index == newIndex) {
                                      isSelected[index] = true;
                                    } else {
                                      isSelected[index] = false;
                                    }
                                  }
                                });

                                sessionLengthIndex = newIndex;
                                sessionTime = sessionTimes[newIndex];
                                pvt_data.Trial_length = sessionTime;
                                print("Session time = $sessionTime");
                              },
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: Text('1 m',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ]),
                                Row(children: <Widget>[
                                  SizedBox(width: 4.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: Text('3 m',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ]),
                                Row(children: <Widget>[
                                  SizedBox(width: 4.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: Text('5 m',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ]),
                                Row(children: <Widget>[
                                  SizedBox(width: 4.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: Text('10 m',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ]),
                              ],
                              constraints: BoxConstraints(
                                  minWidth: (MediaQuery.of(context).size.width -
                                          100) /
                                      4),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ), // Sensor Sampling Rate Selector

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
                      "Experimenter Initials",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      //style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    child: TextField(
                      controller: EI_Controller,
                      cursorColor: Colors.grey,
                      cursorHeight: 30,
                      maxLines: 1,
                      maxLength: 3,
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
                      "Subject ID",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      // style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    child: TextField(
                      controller: SID_Controller,
                      cursorColor: Colors.grey,
                      cursorHeight: 30,
                      maxLines: 1,
                      maxLength: 4,
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: Text(
                      "Subject Initials",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      // style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    child: TextField(
                        controller: SI_Controller,
                        cursorColor: Colors.grey,
                        cursorHeight: 30,
                        maxLines: 1,
                        maxLength: 3,
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
                        //onChanged: (text) {},
                        onChanged: (text) {}),
                  ),

                  Padding(
                    //THIS AREA FOR EMAIL ADDRESS FOR SENDING DATA FILES
                    //right now can only enter email, does not send nor validate
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: Text(
                      "Send Data to this e-mail",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    child: TextField(
                      controller: Email_Controller,
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
                      onChanged: (String value) {
                        final email = value;
                      },
                    ),
                  ), //END OF EMAIL AREA
                ],
              ),
            ), // User Notes

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      style: ButtonStyle(
                          // backgroundColor: MaterialStateProperty.all<Color>(
                          //     Colors.blue.shade900),
                          ),
                      icon: Icon(Icons.check, size: 30),
                      label: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Finished', style: TextStyle(fontSize: 22)),
                      ),
                      onPressed: () {
                        // Navigator.pop(context);
                        pvt_data.E_Initials = EI_Controller.text;
                        pvt_data.S_Initials = SI_Controller.text;
                        pvt_data.S_ID = SID_Controller.text;
                        pvt_data.Main_Email = Email_Controller.text;
                        _setPreference();
                        Navigator.pop(context);
                        // Navigator.pop(context);pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             //  ConfigPage(title: 'PVT - Configure Session')));
                        //             MainMenu(title: 'Main Menu')));
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

  // @override
  // void initState() {
  //   super.initState();
  // }
}
