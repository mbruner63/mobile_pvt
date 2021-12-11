import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'config_page.dart';

final FlutterBlue flutterBlue = FlutterBlue.instance;

class SearchingForDevicesPage extends StatefulWidget {
  SearchingForDevicesPage({Key? key, required this.title}) : super(key: key);

  final String title;
  Map<String, BluetoothDevice>? PvtDeviceMap = {};

  @override
  _SearchingForDevicesPageState createState() =>
      _SearchingForDevicesPageState();
}

class _SearchingForDevicesPageState extends State<SearchingForDevicesPage> {
//  final _writeController = TextEditingController();
//  bool _connectButtonEnabled = false;
//  int _selectedDeviceIndex = -1;
  late Timer _searchingTimer;
  int _searchingTimerCountdown = 10;
  bool _searchInProgress = true;
  bool _connecting = false;
  String _connectingAddress = '';
  late Timer _waitingToConnectTimer;
  int _waitingToConnectCountdown = 10;

  _addDeviceToMap(String address, BluetoothDevice device) {
    if (!widget.PvtDeviceMap!.containsKey(address)) {
      setState(() {
        widget.PvtDeviceMap!.addEntries([new MapEntry(address, device)]);
      });
    }
    // if (!widget.devicesList.contains(device)) {
    //   setState(() {
    //     widget.devicesList.add(device);
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    //MetaWearSDK.scanLeDevice();
    flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        if (r.device.name.length > 1) {
          if ((r.device.name[0] == 'A') && (r.device.name[1] == 'P')) {
            print('${r.device.name} found! ${r.device.id} rssi: ${r.rssi}');
            _addDeviceToMap("${r.device.id}", r.device);
          }
        }
      }
    });

// Stop scanning
    flutterBlue.stopScan();
    _searchingTimerCountdown = 10;
    _searchingTimer = Timer.periodic(Duration(seconds: 1), searchingTimerCB);
  }

  @override
  void dispose() {
    _searchingTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile PVT'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(_connecting ? 'CONNECTING:' : 'SEARCHING',
                  style: Theme.of(context).textTheme.headline4),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                _connecting
                    ? _connectingAddress
                    : 'Now searching for compatible PVT devices...',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            _connecting
                ? Center(
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator()),
                  )
                : Container(
                    height: 200,
                    child: _buildNestedScrollViewOfDevices(),
                  ),
            Container(
              height: 50,
              child: Center(
                  child:
                      _searchInProgress ? CircularProgressIndicator() : null),
            ),
            Container(
              child: _connecting
                  ? null
                  : ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('USE MOBILE DEVICE ',
                            style: Theme.of(context).textTheme.headline5),
                      ),
                      onPressed: () async {
                        //MetaWearSDK.stopLeDeviceScan();
                        //Batch.isMbientBatch = false;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ConfigPage(title: 'Config Page Title')));
                      },
                    ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: _connecting
                  ? null
                  : ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('RESCAN',
                            style: Theme.of(context).textTheme.headline5),
                      ),
                      onPressed: () {
                        //MetaWearSDK.scanLeDevice();
                        _searchingTimerCountdown = 10;
                        setState(() {
                          _searchInProgress = true;
                        });
                        _searchingTimer = Timer.periodic(
                            Duration(seconds: 1), searchingTimerCB);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  NestedScrollView _buildNestedScrollViewOfDevices() {
    List<Container> containers = [];
    widget.PvtDeviceMap?.forEach((address, device) {
      String buttonText = 'CONNECT';
      containers.add(Container(
          height: 60,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device' : device.name),
                    Text(address)
                  ],
                ),
              ),
              _connecting
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(buttonText,
                            style: Theme.of(context).textTheme.headline6),
                      ),
                      onPressed: () {
                        _waitingToConnectCountdown = 30;
                        // _waitingToConnectTimer = Timer.periodic(
                        //     Duration(seconds: 1), waitingToConnectTimerCB);
                        //MetaWearSDK.connectMW(address);
                        setState(() {
                          _connectingAddress = address;
                          _connecting = true;
                          _searchInProgress = false;
                          try {
                            device.connect(timeout: Duration(seconds: 10));
                          } catch (e) {
                            print("connection failed");
                          }
                        });
                      }),
            ],
          )));
    });

    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return _connecting
              ? <Widget>[]
              : <Widget>[
                  SliverAppBar(
                    title: Text('Found Devices'),
                  )
                ];
        },
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            ...containers,
          ],
        ));
  }

  void searchingTimerCB(Timer t) async {
    /*if (_searchingTimerCountdown-- > 1) {
      try {
        var temp = await MetaWearSDK.getDeviceMap();
        setState(() {
          widget.PvtDeviceMap = temp;
        });
      } on Exception catch (e) {
        print('exception in timer callback');
      }
    } else {
      t.cancel();
      if (widget.PvtDeviceMap == null ||
          widget.PvtDeviceMap!.isEmpty) {
        print('no compatible devices found');
        //Navigator.pushReplacement(context,
          //  MaterialPageRoute(builder: (context) => NoDevicesFoundPage()));
      } else {
        setState(() {
          _searchInProgress = false;
        });
      }
    }

     */
  }

  void connectToDevice() {}
  /*
  void waitingToConnectTimerCB(Timer t) async {
    if (_waitingToConnectCountdown-- > 1) {
      var result = await MetaWearSDK.isConnected();
      if (result != null && result) {
        t.cancel();
        // yay we established connected
        MetaWearSDK.flashLedForConnected();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ConnectionSuccessPage(
                      title: 'connection success page',
                    )));
      }
    } else {
      print('did not establish connection in time');
      setState(() {
        _connecting = false;
      });
      t.cancel();
    }
  }

   */
}
