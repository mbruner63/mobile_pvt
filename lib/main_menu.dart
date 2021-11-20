import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_launcher_icons/main.dart';
import 'package:mobile_pvt/config_page.dart';
import 'package:mobile_pvt/rating_page.dart';
//import 'package:mobile_pvt/password_page.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      //title: 'Tremor Measurement POC App',
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Colors.grey[850],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PVT - Main Menu'),
          //backgroundColor: Colors.grey.shade400,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                    minWidth: (MediaQuery.of(context).size.width - 10) / 2),
                // width: double.maxFinite,
                height: 90,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade900),
                    ),
                    icon: Icon(Icons.settings, size: 50),
                    label: Text('Settings',
                        style: Theme.of(context).textTheme.headline5),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfigPage(
                                  title: 'PVT - Configure Session')));
                      // ConfigPage(title: 'PVT - Settings')));
                    },
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                    minWidth: (MediaQuery.of(context).size.width - 10) / 2),
                //width: double.maxFinite,
                height: 90,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade900),
                    ),
                    icon: Icon(Icons.timer, size: 50),
                    label: Text('Begin Test',
                        style: Theme.of(context).textTheme.headline5),
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
              Container(
                constraints: BoxConstraints(
                    minWidth: (MediaQuery.of(context).size.width - 10) / 2),
                //width: double.infinity,
                height: 90,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade900),
                    ),
                    icon: Icon(Icons.door_back_door_outlined, size: 50),
                    label: Text('Exit App',
                        style: Theme.of(context).textTheme.headline5),
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                  ),
                ),
              ),

              // width: double.infinity,
              // child: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ElevatedButton(
              //     style: ButtonStyle(
              //       backgroundColor: MaterialStateProperty.all<Color>(
              //           Colors.blue.shade900),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(16.0),
              //       child: Text('Exit App',
              //           style: Theme.of(context).textTheme.headline5),
              //     ),
              //     onPressed: () {
              //       SystemChannels.platform
              //           .invokeMethod('SystemNavigator.pop');
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
