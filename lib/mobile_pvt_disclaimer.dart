import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_launcher_icons/main.dart';
import 'Copy_protection.dart';
import 'SearchingForDevicesPage.dart';
import 'main.dart';
import 'main_menu.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Mobile PVT - DISCLAIMER',
            // style: TextStyle(fontSize: 20),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 75,
              child: Image.asset(
                //   'assets/appbar_red.png',
                'assets/images/CliniLogo_Lt.png', //CLINILABS
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('DISCLAIMER:',
                  style: Theme.of(context).textTheme.headline4),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'This is a proof-of-concept app for the Psychomotor Vigilance Task (PVT) .\n\n'
                'The Psychomotor Vigilance Task (PVT) is a sustained-attention, reaction-timed task that measures the speed with which subjects respond to a visual stimulus.'
                'This app is intended for investigational data collection purposes ONLY.',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(
                        minWidth: (MediaQuery.of(context).size.width - 10) / 4),
                    child: ElevatedButton(
                      // style: ButtonStyle(
                      //   backgroundColor: MaterialStateProperty.all<Color>(
                      //       Colors.blue.shade900),
                      //   //backgroundColor: MaterialStateProperty.all<Color>(
                      //   //Theme.of(context).primaryColor)
                      // ),
                      //Theme.of(context).primaryColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'I AGREE',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      onPressed: () {
                        onIAgreePressed(context);
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

  void onIAgreePressed(BuildContext context) {
    /*Navigator.pushReplacement(
        //pushes to main menu & replaces disclaimer with main menu at top of the stack
        context,
        MaterialPageRoute(
            builder: (context) => const MainMenu(title: 'Main Menu')));*/
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MainMenu(title: 'Main Menu')));

    // builder: (context) =>
    //     SearchingForDevicesPage(title: 'Searching for Devices')));
    // get batch info
    /*   Batch.timestamp = DateTime.now();
    Batch.sessions = [];
    Batch.currentLocation = null;
    Batch.getLocation();

    // no bluetooth available
//    var retval = await MetaWearSDK.isBleAvailable();
    var retval = await MetaWearSDK.isBleAvailable();
    if(retval != null && !retval)
    {
      Batch.isMbientBatch = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
            ConfigPage(title: 'Config Page Title')
        )
      );
    }
    // go to device search
    else
    {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
            MainMenu(title: 'Main Menu')));
    }
  }*/
  }
}
