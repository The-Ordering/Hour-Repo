import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

class Provider {
  String timeFormater({required TimeOfDay time }) {

    DateTime now  = DateTime.now();
    DateTime dt  = DateTime( now.year ,now.month , now.day ,time.hour,time.minute);
    return dt.format("h:i a");
  }
}