import 'package:audible_mode/audible_mode.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double volume = 0.0;
  double maxVolume = 0.0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Audible.getCurrentVolume.then((value) => setState(() {
          volume = value;
        }));
    await Audible.getMaxVolume.then((value) => setState(() {
          maxVolume = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Audible Mode'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder<AudibleProfile?>(
                  initialData: AudibleProfile.UNDEFINED,
                  stream: Audible.audibleStream,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return const CircularProgressIndicator();
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                      case ConnectionState.done:
                        return Column(
                          children: [
                            Icon(
                              _generateIcon(
                                  snapshot.data ?? AudibleProfile.UNDEFINED),
                              size: 60,
                            ),
                            Text(
                              _generateText(
                                  snapshot.data ?? AudibleProfile.UNDEFINED),
                              style: const TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ],
                        );
                    }
                  },
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Set volume",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Text(
                  volume.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 20),
                ),
                Slider(
                  value: volume,
                  onChanged: (value) => setState(() {
                    volume = value;
                  }),
                  min: 0,
                  max: maxVolume,
                  onChangeEnd: (value) => Audible.setVolume(volume),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _generateText(AudibleProfile profile) {
    switch (profile) {
      case AudibleProfile.SILENT_MODE:
        return "Silent mode";
      case AudibleProfile.VIBRATE_MODE:
        return "Vibration mode";
      case AudibleProfile.NORMAL_MODE:
        return "Normal mode";
      case AudibleProfile.UNDEFINED:
        return "Undefinded";
    }
  }

  IconData _generateIcon(AudibleProfile profile) {
    switch (profile) {
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
