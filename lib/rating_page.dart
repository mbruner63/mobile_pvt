import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pvt/countdown_page.dart';
import 'package:mobile_pvt/main_menu.dart';

class RatingPage extends StatefulWidget {
  RatingPage({Key? key, required this.title}) : super(key: key) {}

  final String title;

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double _currentSliderValue = 5;
  _RatingPageState() {}
  int i = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PVT - Configure Session'),
        //backgroundColor: Colors.grey.shade800,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32), //fromLTRB(16, 24, 16, 8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[850],
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
                        'How do you feel?      $_currentSliderValue',
                        style: Theme.of(context).textTheme.headline6,
                        //textAlign: TextAlign.end,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        child: Slider(
                          activeColor: Colors.blue.shade900,
                          value: _currentSliderValue,
                          min: 1,
                          max: 10,
                          divisions: 9,
                          label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                        )),
                  ],
                ),
              ),
            ), // How do you feel
            Padding(
              padding: const EdgeInsets.all(
                  32), //.symmetric(vertical: 18, horizontal: 32),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue.shade900),
                ),
                icon: Icon(Icons.timer, size: 30),
                label: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Begin Test',
                      style: Theme.of(context).textTheme.headline5),
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CountdownPage(
                              title: 'PVT - Prepare to start')));
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
