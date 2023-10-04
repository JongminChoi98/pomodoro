import 'package:flutter/material.dart';
import 'package:pomodoro/constants/sizes.dart';
import 'package:pomodoro/models/timer_model.dart';
import 'package:pomodoro/screens/settings_page.dart';
import 'package:pomodoro/utilities/timer_util.dart';
import 'package:pomodoro/widgets/reset_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TimerModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingPage(),
                    ),
                  );
                },
                child: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.primary,
                  size: Sizes.size32,
                ),
              ),
            ],
          )
        ],
      ),
      body: Consumer<TimerModel>(
        builder: (context, timer, child) {
          return SafeArea(
            child: Column(
              children: [
                Text(
                  timeFormat(timer.isResting
                      ? timer.remainRestSeconds
                      : timer.remainWorkSeconds),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: Sizes.size96,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Pomodoro Count: ${pomodoroCountFormat(timer.totalPomodoroCount)}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: Sizes.size36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: Sizes.size96 + Sizes.size24,
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: model.onToggleStartPause,
                      //TODO: Pause icon not changing while isResting time and press pause
                      //TODO: After 15 pomodoro count => The time is getting faster and faster
                      icon: Icon(timer.isRunning || timer.isResting
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline),
                    ),
                    const ResetButton()
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
