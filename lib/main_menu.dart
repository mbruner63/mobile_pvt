import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_pvt/config_page.dart';
import 'package:mobile_pvt/rating_page.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Tremor Measurement POC App',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.deepPurple.shade900,
          accentColor: Colors.deepPurple.shade300,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          backgroundColor: Colors.grey.shade900,
          textTheme: const TextTheme(
              headline4: TextStyle(fontSize: 36, fontWeight: FontWeight.bold))),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Main Menu'),
          backgroundColor: Colors.blueGrey[700],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Settings',
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ConfigPage(title: 'PVT - Settings')));
                    },
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Begin Test',
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RatingPage(title: 'PVT - Rating')));
                    },
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Exit App',
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
