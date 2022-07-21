import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_launcher_icons/main.dart';
import 'package:mobile_pvt/config_page.dart';
import 'package:mobile_pvt/rating_page.dart';
import '/main.dart';
import 'Copy_protection.dart';
import 'form_page.dart';
import 'licensing_form.dart';

int settingsLicenseSelect = 0;

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('PVT - Main Menu'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 75,
              // child: Image.asset(
              //'assets/images/splash_trans.png',  //generic pvt
              // 'assets/images/ami_206red.png', //AMI
              // 'assets/images/CliniLogo_Lt.png', //CLINILABS
              // ),
            ),
          ),
        ],
        //backgroundColor: Colors.grey.shade400,
      ),
      //backgroundColor: Theme.of(context).backgroundColor,
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
                  style: ButtonStyle(),
                  icon: Icon(Icons.settings, size: 50),
                  label: Text('Settings', style: TextStyle(fontSize: 24)),
                  onPressed: () {
                    settingsLicenseSelect = 0;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                //  ConfigPage(title: 'PVT - Configure Session')));
                                FormPage(title: 'PVT - Unlock Settings')));
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
                  // style: ButtonStyle(
                  //   backgroundColor: MaterialStateProperty.all<Color>(
                  //       Colors.blue.shade900),
                  // ),
                  icon: Icon(Icons.timer, size: 50),
                  label: Text('Begin Test', style: TextStyle(fontSize: 24)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RatingPage(title: 'PVT - Pre-Session Rating')));
                  },
                ),
              ),
            ),
            Container(
              //licensing
              constraints: BoxConstraints(
                  minWidth: (MediaQuery.of(context).size.width - 10) / 2),
              // width: double.maxFinite,
              height: 90,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ButtonStyle(),
                  icon: Icon(Icons.vpn_key_sharp, size: 45),
                  label: Text(' Licensing', style: TextStyle(fontSize: 24)),
                  onPressed: () async {
                    settingsLicenseSelect = 1;
                    myint = 1;
                    state = await readCopyProtection();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                //  ConfigPage(title: 'PVT - Configure Session')));
                                FormPage(title: 'PVT - App Licensing')));
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
                  // style: ButtonStyle(
                  //   backgroundColor: MaterialStateProperty.all<Color>(
                  //       Colors.blue.shade900),
                  // ),
                  icon: Icon(Icons.door_back_door_outlined, size: 50),
                  label: Text('Exit App', style: TextStyle(fontSize: 24)
                      //Theme.of(context).textTheme.headline5
                      ),
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
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
    );
  }
}
