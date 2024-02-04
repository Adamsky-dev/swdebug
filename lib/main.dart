import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StopWatch Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SWPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class SWPage extends StatefulWidget {
  const SWPage({super.key, required this.title});

  final String title;

  @override
  State<SWPage> createState() => _SWPageState();
}

class _SWPageState extends State<SWPage> {
  Stopwatch stopwatch = Stopwatch();
  Timer? timer;
  bool started = false;

  void handleStartStop() {
    if (timer == null) {
      timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
        setState(() {});
      });
    } else {
      timer!.cancel();
      timer = null;
    }

    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      stopwatch.start();
    }

    setState(() {
      started = !started;
    });
  }

  String returnFormattedText() {
    var milli = stopwatch.elapsed.inMilliseconds;

    String milliseconds = (milli % 1000).toString().padLeft(3, '0');
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, '0');
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, '0');

    return '$minutes:$seconds:$milliseconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              key: const Key('timerText'),
              returnFormattedText(),
            ),
            TextButton(
              key: const Key('btnStartStop'),
              onPressed: () {
                handleStartStop();
              },
              child: started ? const Text('Stop') : const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
