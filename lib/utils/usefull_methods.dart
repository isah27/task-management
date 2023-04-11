import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UseFullMethods {
  static Color statusColor({required String status}) {
    if (status == "i") {
      return Colors.black;
    } else if (status == "s") {
      return Colors.blue.shade900;
    } else {
      return Colors.green.shade700;
    }
  }

  static String dateFormat({required String date}) {
    return DateFormat.yMd().format(DateTime.parse(date));
  }
}
