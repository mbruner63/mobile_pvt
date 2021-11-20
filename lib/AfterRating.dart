import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:mobile_pvt/countdown_page.dart';
import 'package:mobile_pvt/main_menu.dart';

class PostRatingPage extends StatefulWidget {
  PostRatingPage({Key? key, required this.title}) : super(key: key) {}

  final String title;

  @override
  _PostRatingPageState createState() => _PostRatingPageState();
}

class _PostRatingPageState extends State<PostRatingPage> {
  double _currentSliderValue = 5;
  _PostRatingPageState() {}
  int i = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PVT - Post Session Rating'),
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
                          vertical: 8, horizontal: 4),
                      child: Text(
                        ' Post session, how do you feel? $_currentSliderValue',

                        style: Theme.of(context).textTheme.headline6,
                        //.of(context).textTheme.headline6,
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
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(
                        minWidth:
                            (MediaQuery.of(context).size.width - 100) / 2),
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue.shade900),
                      ),
                      icon: Icon(Icons.check, size: 30),
                      label: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Done',
                            style: Theme.of(context).textTheme.headline5),
                      ),
                      // onPressed: () {
                      //   Navigator.pop(context);
                      // },
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MainMenu(title: 'PVT - Main Menu')));
                      },
                    ),
                  ),
                ],
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
