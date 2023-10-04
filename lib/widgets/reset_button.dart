import 'package:flutter/material.dart';
import 'package:pomodoro/constants/sizes.dart';
import 'package:pomodoro/models/timer_model.dart';
import 'package:provider/provider.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  void _onResetPress(BuildContext context) {
    final model = Provider.of<TimerModel>(context, listen: false);
    if (model.isRunning || model.isResting) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            'Are you sure you want to reset?',
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<TimerModel>().onResetPressed();
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),

        //TODO: Timer Pause when press reset
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: Sizes.size96 + Sizes.size24,
      color: Theme.of(context).colorScheme.primary,
      onPressed: () => _onResetPress(context),
      icon: const Icon(
        Icons.replay_rounded,
      ),
    );
  }
}
