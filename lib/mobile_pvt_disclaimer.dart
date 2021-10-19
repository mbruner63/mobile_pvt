import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_menu.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile PVT - DISCLAIMER'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
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
                'This is a proof-of-concept app The psychomotor vigilance task (PVT) .\n\n'
                'The psychomotor vigilance task (PVT) is a sustained-attention, reaction-timed task that measures the speed with which subjects respond to a visual stimulus.'
                'This app is intended for investigational data collection purposes ONLY.',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('I AGREE',
                      style: Theme.of(context).textTheme.headline5),
                ),
                onPressed: () {
                  onIAgreePressed(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onIAgreePressed(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MainMenu(title: 'Main Menu')));
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