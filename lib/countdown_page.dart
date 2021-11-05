import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  late Timer _timer;
  late int _countdownCount;

  @override
  void initState() {
    super.initState();
    _countdownCount = 5;

    _timer = Timer.periodic(const Duration(seconds: 1), countdownTimerCB);
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
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return SessionPage(title: 'PVT Session Page');
        }));
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PVT - Countdown'),
        // backgroundColor: Colors.grey.shade800,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Text('Session Countdown',
                style: Theme.of(context).textTheme.headline6),
          ),
          Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                  'Hold smartphone device throughout the entire session.\n\n'
                  'Session will automatically begin in:',
                  style: Theme.of(context).textTheme.headline6)),
          Center(
            child: Text(
              '$_countdownCount',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red.shade800)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Text('CANCEL SESSION',
                      style: Theme.of(context).textTheme.headline6),
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
            ),
          ),
        ],
      ),
    );
  }
}
