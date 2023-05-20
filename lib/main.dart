import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        hintColor: Colors.purpleAccent,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stopwatch'),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.purple.withOpacity(0.1),
              border: Border.all(
                color: Colors.purple.withOpacity(0.3),
                width: 8.0,
              ),
            ),
            child: StopwatchScreen(),
          ),
        ),
      ),
    );
  }
}

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  Duration _currentTime = Duration();
  bool _isRunning = false;

  @override
  void dispose() {
    _timer?.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  void _startStopwatch() {
    setState(() {
      _isRunning = true;
      _stopwatch.start();
      _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
        _updateTime();
      });
    });
  }

  void _pauseStopwatch() {
    setState(() {
      _isRunning = false;
      _stopwatch.stop();
      _timer?.cancel();
    });
  }

  void _resetStopwatch() {
    setState(() {
      _isRunning = false;
      _stopwatch.stop();
      _stopwatch.reset();
      _currentTime = Duration();
    });
  }

  void _updateTime() {
    setState(() {
      _currentTime = _stopwatch.elapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _currentTime.toString().substring(0, 10),
            style: TextStyle(fontSize: 48),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isRunning ? _pauseStopwatch : _startStopwatch,
                child: Text(_isRunning ? 'Pause' : 'Start'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _resetStopwatch,
                child: Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
