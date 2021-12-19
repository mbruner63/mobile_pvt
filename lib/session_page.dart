import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'PVTData.dart';
import 'main.dart';
import 'main_menu.dart';
import 'AfterRating.dart';

//DateTime.now()
class SessionPage extends StatefulWidget {
  SessionPage({Key? key, required this.title}) : super(key: key) {}

  final String title;

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  _SessionPageState() {}

  late Timer _timer;
  bool showTarget = false;
  bool showTime = false;
  late int _delay = 0;
  int startMilliseconds = 0;
  //List<int> reactionTimes = [];
  int reactionTime = 0;
  int session_start_milliseconds = 0;
  int running_milliseconds = 0;
  //List<int> stimulationTimes = [];

  late Random rnd;
  bool enabled = false;
  late int _secondsRemaining;
  @override
  void initState() {
    pvt_data.ResetData();
    pvt_data.Set_Date_Time();
    super.initState();
    rnd = Random();
    _delay = 1 + rnd.nextInt(9);
    _secondsRemaining = sessionTime;
    session_start_milliseconds = DateTime.now().millisecondsSinceEpoch;
    _timer = Timer.periodic(const Duration(seconds: 1), countdownTimerCB);
  }

  void countdownTimerCB(Timer t) {
    if (_secondsRemaining > 0) {
      setState(() {
        --_secondsRemaining;
      });
      if (_delay > 0) {
        --_delay;
        if (_delay < 1) {
          setState(() {
            showTarget = true;
            startMilliseconds = DateTime.now().millisecondsSinceEpoch;
            pvt_data.stimulationTimes.add(
                DateTime.now().millisecondsSinceEpoch -
                    session_start_milliseconds);
          });
        }
      }
    } else {
      t.cancel();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PostRatingPage(title: 'PVT - Post Session Rating')),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: const Text(
            'PVT Session in Progress',
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
      //backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                child: Text('Session In Progress',
                    style: Theme.of(context).textTheme.headline6)),
            const Padding(
              padding: EdgeInsets.all(4),
            ),
            /* Temporary data output below */
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(child: Text('Time: $reactionTime')),
                        Expanded(
                          child: FittedBox(
                              //width: 250,
                              //height: 250,
                              child: showTarget
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showTarget = false;
                                          reactionTime = DateTime.now()
                                                  .millisecondsSinceEpoch -
                                              startMilliseconds;
                                          pvt_data.reactionTimes
                                              .add(reactionTime);
                                          _delay = 1 + rnd.nextInt(9);
                                        });
                                      },
                                      child: const Image(
                                          image: AssetImage(
                                              'assets/images/pvt_target5.png')),
                                    )
                                  : null),
                        ),
                      ],
                    ),
                  ),
                  /* Temporary data output above */
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
              child: Text('Session Time Remaining: $_secondsRemaining',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red.shade800)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('ABORT SESSION', style: TextStyle(fontSize: 18)),
                ),
                onPressed: () async {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MainMenu(title: 'PVT MainMenu')),
                      (Route<dynamic> route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
