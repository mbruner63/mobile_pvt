import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pvt/main_menu.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '/main.dart';

List<int> sessionTimes = [60, 300, 600];

class ConfigPage extends StatefulWidget {
  ConfigPage({Key? key, required this.title}) : super(key: key) {}

  final String title;

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  _ConfigPageState() {}
  int i = 5;

  @override
  Widget build(BuildContext context) {
    int sessionLengthIndex = 0;
    switch (sessionLengthIndex) {
      case 60:
        sessionLengthIndex = 0;
        break;
      case 300:
        sessionLengthIndex = 1;
        break;
      case 600:
        sessionLengthIndex = 2;
        break;
      default:
        sessionLengthIndex = 0;
        break;
    }
    switch (sessionTime) {
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('PVT - Configure Session'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  border: Border.all(color: Colors.grey.shade500, width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 8),
                      child: Text(
                        'Session length',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
                      child: ToggleSwitch(
                        initialLabelIndex: sessionLengthIndex,
                        activeFgColor: Colors.white,
                        activeBgColors: [
                          Colors.deepPurple.shade900,
                          Colors.deepPurple.shade900,
                          Colors.deepPurple.shade900,
                        ],
                        inactiveFgColor: Colors.white70,
                        inactiveBgColor: Colors.grey.shade600,
                        labels: const ['1 m', '5 m', '10 m'],
                        fontSize: 20,
                        minWidth: 96,
                        minHeight: 48,
                        onToggle: (index) {
                          sessionLengthIndex = index;
                          sessionTime = sessionTimes[index];
                          print("Session time = $sessionTime");
                        },
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
                      "Experimenter ID",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    child: TextField(
                      maxLines: 1,
                      maxLength: 3,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {},
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: Text(
                      "Subject ID",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    child: TextField(
                      maxLines: 1,
                      maxLength: 3,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {},
                    ),
                  ),
                ],
              ),
            ), // User Notes

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Finished',
                      style: Theme.of(context).textTheme.headline6),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
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
