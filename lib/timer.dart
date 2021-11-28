import 'dart:async';

import 'package:flutter/material.dart';

const maxSeconds = 59;
const maxMins = 5;
int seconds = maxSeconds;
int mins = maxMins;
Timer? time;

Widget timer() {
  if (seconds < 10) {
    return Text(
      "0$mins : 0$seconds",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  } else {
    return Text(
      "0$mins : $seconds",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  }
}

