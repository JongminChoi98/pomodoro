import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/constants/sizes.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  static const _defaultSeconds = 1500;
  int _remainSeconds = _defaultSeconds;
  bool _isRunning = false;
  late Timer _timer;

  void _onTick(Timer timer) {
    if (_remainSeconds == 0) {
      setState(() {
        _isRunning = false;
        _remainSeconds = _defaultSeconds;
      });
      timer.cancel();
    } else {
      setState(() {
        _remainSeconds = _remainSeconds - 1;
      });
    }
  }

  void _onStartPressed() {
    _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    setState(() {
      _isRunning = true;
    });
  }

  void _onPausePressed() {
    setState(() {
      _timer.cancel();
      _isRunning = false;
    });
  }

  void _onResetPressed() {
    setState(() {
      _timer.cancel();
      _isRunning = false;
      _remainSeconds = _defaultSeconds;
    });
  }

  String _timeFormat(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              _timeFormat(_remainSeconds),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: Sizes.size96,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: Sizes.size96 + Sizes.size24,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: _isRunning ? _onPausePressed : _onStartPressed,
                  icon: Icon(_isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline),
                ),
                IconButton(
                  iconSize: Sizes.size96 + Sizes.size24,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: _onResetPressed,
                  icon: const Icon(
                    Icons.replay_rounded,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
