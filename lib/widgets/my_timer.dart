import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizTimer extends StatefulWidget {
  final int examDurationInSeconds;

  const QuizTimer({super.key, required this.examDurationInSeconds});

  @override
  State<QuizTimer> createState() => _QuizTimerState();
}

class _QuizTimerState extends State<QuizTimer> {
  late Timer _timer;
  late int _timeRemaining;
  bool isDesktop = kIsWeb;

  @override
  void initState() {
    super.initState();
    _timeRemaining = widget.examDurationInSeconds;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          _timer.cancel();
          // You can add exam submission logic here
        }
      });
    });
  }

  String formatTime(int timeInSeconds) {
    int hours = timeInSeconds ~/ 3600;
    int minutes = (timeInSeconds % 3600) ~/ 60;
    int seconds = timeInSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.timer,
          color: Colors.red,
          size: isDesktop ? 8.sp : 24.0,
        ),
        SizedBox(width: isDesktop ? 3.sp : 10.0),
        Text(
          formatTime(_timeRemaining),
          style: TextStyle(
            color: Colors.red,
            fontSize: isDesktop ? 6.sp : 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}