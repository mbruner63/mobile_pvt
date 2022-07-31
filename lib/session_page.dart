import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Copy_protection.dart';
import 'PVTData.dart';
import 'PVTFile.dart';
import 'main.dart';
import 'main_menu.dart';
import 'AfterRating.dart';
import 'package:wakelock/wakelock.dart';

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
  late Timer ISI_timer;
  bool showTarget = false;
  bool showTime = false;
  int ISI_delay = 0;
  int startMilliseconds = 0;
  //List<int> reactionTimes = [];
  int reactionTime = 0;
  int session_start_milliseconds = 0;
  int running_milliseconds = 0;
  //List<int> stimulationTimes = [];

  late Random rnd;
  bool enabled = false;
  late int _secondsRemaining;
  SharedPreferences? preferences;
  Future<void> initializePreference() async {
    this.preferences = await SharedPreferences.getInstance();
    pvt_data.E_Initials = this.preferences?.getString("einitials") ?? "jkb";
    pvt_data.S_Initials = this.preferences?.getString("sinitials") ?? "mlb";
    pvt_data.S_ID = this.preferences?.getString("sid") ?? "0001";
    pvt_data.Main_Email =
        this.preferences?.getString("email") ?? "marty@bruner-consulting.com";
    pvt_data.Trial_length = this.preferences?.getInt("Trial_length") ?? 60;
  }

  @override
  void initState() {
    initializePreference().whenComplete(() {
      pvt_data.ResetData();
      pvt_data.Set_Date_Time();

      rnd = Random();
      Wakelock.enable();
      //ISI_delay = 1 + rnd.nextInt(9);
      _secondsRemaining = pvt_data.Trial_length;
      session_start_milliseconds = DateTime.now().millisecondsSinceEpoch;
      _timer = Timer.periodic(const Duration(seconds: 1), countdownTimerCB);
      setISI();
    });
    super.initState();
  }

  void ISITimerCB() {
    setState(() {
      showTarget = true;
      //targetShown = false;
      startMilliseconds = DateTime.now().millisecondsSinceEpoch;
      pvt_data.stimulationTimes.add(
          DateTime.now().millisecondsSinceEpoch - session_start_milliseconds);
    });
  }

  void setISI() {
    ISI_delay = 1000 + rnd.nextInt(9000);

    ISI_timer = Timer(Duration(milliseconds: ISI_delay), ISITimerCB);
  }

  Future<void> countdownTimerCB(Timer t) async {
    if (_secondsRemaining > 0) {
      setState(() {
        --_secondsRemaining;
        print(_secondsRemaining);
      });

      // put code here that will cause a timeout (9 seconds)
      // save reaction time and go into a delay.
      // look at UI code (target press) to figure out how to do this.
      var TimeoutTime =
          DateTime.now().millisecondsSinceEpoch - startMilliseconds - 150;
      if ((TimeoutTime > 9999) && showTarget) {
        print("Timeout!!!");
        setState(() {
          reactionTime = 9999;
          showTarget = false;
          /* pvt_data.stimulationTimes.add(DateTime.now().millisecondsSinceEpoch -
              session_start_milliseconds);*/
          ISI_timer.cancel();
          pvt_data.reactionTimes.add(9999);
          print('reaction time added -> ${pvt_data.reactionTimes.length}');
          setISI();
        });
      }
    } else {
      t.cancel();
      Wakelock.disable();
      copyProtectedState = await readCopyProtection();
      if (copyProtectedState > 0) {
        writePVTFile(); //taken out for Sanita's trade show 04/15/2022
      }
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const MainMenu(title: 'PVT - Main Menu')),
          //when we remove the post rating page-HOW DO WE HANDLE DATA & EMAIL?
          //Post rating page to be removed 7/21/22
          //PostRatingPage(title: 'PVT - Post Session Rating')),
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
            padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "v " + packageInfo.version,
                  style: TextStyle(fontSize: 20),
                ),
              ],
              // padding: const EdgeInsets.all(4.0),
              // child: Container(
              //   width: 75,
              //  child: Image.asset(
              //'assets/image/splash_trans206.png', //generic pvt
              //  'assets/images/ami_test206red.png', //AMI logo
              // 'assets/images/CliniLogo_Lt.png', //CLINILABS
              // ),
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
                        Center(
                          child: (reactionTime != 1)
                              ? Text(
                                  'Reaction Time: $reactionTime',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                      color: Colors.red),
                                )
                              : Text(
                                  'False Start',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 34,
                                      color: Colors.red),
                                ),
                        ),
                        Expanded(
                          child: FittedBox(
                              //width: 250,
                              //height: 250,
                              child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!showTarget) {
                                  reactionTime = 1;
                                  pvt_data.stimulationTimes.add(
                                      DateTime.now().millisecondsSinceEpoch -
                                          session_start_milliseconds);
                                  ISI_timer.cancel();
                                } else {
                                  reactionTime =
                                      DateTime.now().millisecondsSinceEpoch -
                                          startMilliseconds -
                                          150;
                                  showTarget = false;
                                }

                                if (reactionTime < 100) {
                                  reactionTime = 1;
                                }
                                pvt_data.reactionTimes.add(reactionTime);

                                print(
                                    'reaction time added -> ${pvt_data.reactionTimes.length}');
                                //_delay = 1 + rnd.nextInt(9);
                              });
                              setISI();
                            },
                            child: showTarget
                                ? const Image(
                                    image: AssetImage(
                                        'assets/images/pvt_target5.png'))
                                : const Image(
                                    image: AssetImage(
                                        'assets/images/transparent.png')),
                          )),
                        )
                      ],
                    ),
                  ),
                  /* Temporary data output above */
                ),
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
              child: Text('Session Time Remaining: $_secondsRemaining',
                  style: Theme.of(context).textTheme.bodyText1),
            ),*/
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
                  Wakelock.disable();
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
    _timer.cancel();
    ISI_timer.cancel();
    super.dispose();
  }
}
