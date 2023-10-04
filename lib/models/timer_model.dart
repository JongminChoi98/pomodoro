import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class TimerModel extends ChangeNotifier {
  static const _defaultWorkSeconds = 3;
  static const _defaultRestSeconds = 3;
  static const _defaultPomodoroCount = 0;
  int _remainWorkSeconds = _defaultWorkSeconds;
  int _remainRestSeconds = _defaultRestSeconds;
  int _totalPomodoroCount = _defaultPomodoroCount;
  bool _isRunning = false;
  bool _isResting = false;
  late Timer _timer;

  // Getters and Setters
  bool get isRunning => _isRunning;
  bool get isResting => _isResting;
  int get totalPomodoroCount => _totalPomodoroCount;
  int get remainWorkSeconds => _remainWorkSeconds;
  set remainWorkSeconds(int workSecond) {
    _remainWorkSeconds = workSecond;
    notifyListeners();
  }

  int get remainRestSeconds => _remainRestSeconds;
  set remainRestSeconds(int restSecond) {
    _remainRestSeconds = restSecond;
    notifyListeners();
  }

  final player = AudioPlayer();

  void _workFinshAudio() async {
    await player.setAsset("assets/audio/mixkit-alarm-tone-996.wav");
    player.play();
  }

  void _restFinshAudio() async {
    await player.setAsset("assets/audio/mixkit-classic-alarm-995.wav");
    player.play();
  }

  // Might need to change to optimize
  void _onTick(Timer timer) {
    if (_remainWorkSeconds == 0) {
      if (_isRunning) {
        _isRunning = false;
        _workFinshAudio();
      }

      if (_remainRestSeconds != 0) {
        if (!_isResting) {
          _totalPomodoroCount = _totalPomodoroCount + 1;
        }
        _isResting = true;
        _remainRestSeconds = _remainRestSeconds - 1;
      } else {
        _restFinshAudio();
        _isResting = false;
        _isRunning = true;
        _remainWorkSeconds = _defaultWorkSeconds;
        _remainRestSeconds = _defaultRestSeconds;
      }
    } else {
      _remainWorkSeconds = _remainWorkSeconds - 1;
    }
    notifyListeners();
  }

  void onToggleStartPause() {
    if (_isRunning) {
      _timer.cancel();
      _isRunning = false;
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
      _isRunning = true;
    }
    notifyListeners();
  }

  void onResetPressed() {
    if (_isRunning) {
      _timer.cancel();
      _isRunning = false;
    }

    _isResting = false;
    _remainWorkSeconds = _defaultWorkSeconds;
    _remainRestSeconds = _defaultRestSeconds;
    _totalPomodoroCount = _defaultPomodoroCount;
    notifyListeners();
  }
}
