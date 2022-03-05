import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_pvt/session_page.dart';

import 'main.dart';
import 'main_menu.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  _CountdownPageState() {}

  //late Timer _timer;
  late int _countdownCount;

  @override
  void initState() {
    super.initState();
    _countdownCount = 90;
    //changed from 5 to 90s for testing

    //_timer = Timer.periodic(const Duration(seconds: 1), countdownTimerCB);
  }

  void countdownTimerCB(Timer t) {
    if (_countdownCount > 0) {
      setState(() {
        --_countdownCount;
      });
    } else {
      t.cancel();
      startTime = DateTime.now();
      Future.delayed(const Duration(milliseconds: 300), () {
        //Navigator.pushReplacement(context,
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return SessionPage(title: 'PVT Session Page');
        }));
      });
    }
  }

  @override
  void dispose() {
    //_timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: const Text(
            'PVT - Countdown',
            // style: TextStyle(fontSize: 20),
          ),
        ),
        // title: const Text('PVT Session in Progress'),
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
        //backgroundColor: Colors.grey.shade800,
      ),
      // appBar: AppBar(
      //   title: const Text('PVT - Countdown'),
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
      //   // backgroundColor: Colors.grey.shade800,
      // ),
      //backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text('Session Countdown',
                style: Theme.of(context).textTheme.headline6),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
              child: Text(
                  'Hold smartphone device throughout the entire session.  Use the preferred finger of your dominant hand for all tests.  When the target is presented, tap the target as quickly as possible.  The numbers at the top of the display show how fast you have responded each time- the smaller the number, the better you did.  Try to do your best and get the lowest number you possibly can each time you see the target.  If you press too early (before the target appears) you will see an error message “False Start.”  If you forget to release the target, after a short time the test screen will remind you. '
                  // 'Hold smartphone device throughout the entire session.\n\n'
                  // 'Session will automatically begin in:'
                  ,
                  style: Theme.of(context).textTheme.headline6)),
          //comment out countdown per toms request and replace with button
          // Center(
          //   child: Text(
          //     '$_countdownCount',
          //     style: Theme.of(context).textTheme.headline1,
          //   ),
          // ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green.shade800)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      child: Text('Tap Here to Continue',
                          style: TextStyle(fontSize: 24)),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return SessionPage(title: 'PVT Session Page');
                      }));
                    },
                  ),
                  SizedBox(
                    width: 5,
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red.shade800)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      child: Text('CANCEL SESSION',
                          style: TextStyle(fontSize: 20)),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MainMenu(title: 'PVT - Main Menu')),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
