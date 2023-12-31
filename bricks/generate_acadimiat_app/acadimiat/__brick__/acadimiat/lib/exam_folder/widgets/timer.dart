
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:acadmiat/features/my_courses_feature/domain/entities/myquizizz_entity.dart';
import 'package:acadmiat/features/profile_feature/presentation/bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:percent_indicator/percent_indicator.dart';

import 'package:acadmiat/features/my_courses_feature/presentation/bloc/bloc.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/bloc/my_courses_bloc.dart';

import '../../Theme/style.dart';
import '../../core/functions.dart';
import '../../core/globals.dart';
import '../../features/my_courses_feature/domain/use_cases/submit_quiz_usecase.dart';
import '../../launch_page.dart';
import '../exam_page.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget(
      {Key? key,
        // required this.timeLimit,
        required this.myQuizizzEntity})
      : super(key: key);
  // final int timeLimit;
  final MyQuizizzEntity myQuizizzEntity;
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Duration oneDecimal = const Duration(milliseconds: 100);
  int start = 0;
  bool firstOne = true;
  bool allowSend = true;

  @override
  void initState() {
    Duration timerTastoPremuto = Duration(seconds: widget.myQuizizzEntity.timeLimit * 60);
    start = timerTastoPremuto.inMilliseconds;
  }



  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(milliseconds: start);

    if (firstOne) {
      firstOne = false;
      Timer.periodic(
          oneDecimal,
              (Timer timer) => setState(() {
            if (start < 100) {
              timer.cancel();
            } else {
              start = start - 100;
            }
          }));
    }

    if (duration.inSeconds == 0) {
      if (allowSend) {
        allowSend = false;
        BlocProvider.of<MyCoursesBloc>(context).add(SubmitQuizEvent(
            submitQuizParams: SubmitQuizParams(
                connectionId: connection.connectionId!,
                submitQuiz: SubmitQuiz(
                  userId: userId(),
                  attendedAt: DateTime.now(),
                  finished: true,
                  quizzId: widget.myQuizizzEntity.id,
                  attendanceTable: attendanceTable,
                ))));
      }
    }
    return Row(
      children: [
        Container(
          constraints: const BoxConstraints(
            minWidth: 100
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10)
                
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Text(
                  formatDuration(duration),
                  style: blackBoldTextStyle(
                      color: (duration.inSeconds > 10)
                          ? Theme.of(context).canvasColor
                          : Colors.red,
                      context: context,
                      fontSize: 20,//(duration.inSeconds > 10) ? 30 : 35
                  ),
                ),

                Text("وقت الاختبار",style: blackBoldTextStyle(fontSize: 10, context: context),)
              ],
            ),
          ),
        ),
        // const SizedBox(
        //   width: 16,
        // ),
        // Stack(
        //   alignment: Alignment.center,
        //   children: [
        //     SvgPicture.asset(
        //       "assets/svgs/timer.svg",
        //     ),
        //     CircularPercentIndicator(
        //       animation: true,
        //       animationDuration: 1000,
        //       radius: 10,
        //       lineWidth: 10.0,
        //       percent: 50 / 100,
        //       progressColor: Theme.of(context).primaryColor,
        //     ),
        //   ],
        // ),
      ],
    );
  }

  static String formatDuration(Duration d) {
    var seconds = d.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}');
    }
    tokens.add('${seconds}');

    return tokens.join(':');
  }
}