import 'dart:async';

import 'package:audible_mode/audible_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudibleProfile _audibleProfile = AudibleProfile.UNDEFINED;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    AudibleProfile audibleProfile;
    try {
      audibleProfile = await Audible.getDeviceMode ?? AudibleProfile.UNDEFINED;
    } on PlatformException {
      audibleProfile = AudibleProfile.UNDEFINED;
    }
    if (!mounted) return;
    setState(() {
      _audibleProfile = audibleProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Audible Mode'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_audibleProfile\n'),
              MaterialButton(
                onPressed: () {
                  initPlatformState();
                },
                child: Text("Check"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
