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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  _generateIcon(),
                  size: 50,
                ),
              ),
              Text(
                _generateText(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () {
                    initPlatformState();
                  },
                  color: Colors.blue,
                  child: Text(
                    "Check mode",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _generateText() {
    switch (_audibleProfile) {
      case AudibleProfile.SILENT_MODE:
        return "Silent mode";
      case AudibleProfile.VIBRATE_MODE:
        return "Vibration mode";
      case AudibleProfile.NORMAL_MODE:
        return "Normal mode";
      case AudibleProfile.UNDEFINED:
        return "undefinded";
    }
  }

  IconData _generateIcon() {
    switch (_audibleProfile) {
      case AudibleProfile.SILENT_MODE:
        return Icons.volume_off;
      case AudibleProfile.VIBRATE_MODE:
        return Icons.vibration;
      case AudibleProfile.NORMAL_MODE:
        return Icons.volume_up;
      case AudibleProfile.UNDEFINED:
        return Icons.clear;
    }
  }
}
