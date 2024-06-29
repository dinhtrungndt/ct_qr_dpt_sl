import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../model/hrm_model/attendance_model.dart';

int weeksOfYear(DateTime date) {
  final startOfYear = DateTime(date.year, 1, 1, 0, 0);
  final firstMonday = startOfYear.weekday;
  final daysInFirstWeek = 8 - firstMonday;
  final diff = date.difference(startOfYear);
  var weeks = ((diff.inDays - daysInFirstWeek) / 7).ceil();
  if (daysInFirstWeek > 3) {
    weeks += 1;
  }
  return weeks;
}

String acronymName(String name) {
  if (name.isEmpty) return '';
  List<String> listString = name.trim().split(' ');
  if (listString.length == 1) {
    return listString.first.characters.first.toUpperCase();
  }
  return listString.first.characters.first.toUpperCase() +
      listString.last.characters.first.toUpperCase();
}

int daysInMonth(DateTime date) {
  var firstDayThisMonth = DateTime(date.year, date.month, date.day);
  var firstDayNextMonth = DateTime(firstDayThisMonth.year,
      firstDayThisMonth.month + 1, firstDayThisMonth.day);
  return firstDayNextMonth.difference(firstDayThisMonth).inDays;
}

bool checkToday(DateTime date) {
  DateTime now = DateTime.now();
  if (now.year != date.year) return false;
  if (now.month != date.month) return false;
  if (now.day != date.day) return false;
  return true;
}

bool checkYesterday(DateTime date) {
  DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
  if (yesterday.year != date.year) return false;
  if (yesterday.month != date.month) return false;
  if (yesterday.day != date.day) return false;
  return true;
}

String getToday(DateTime date, BuildContext context) {
  if (checkToday(date)) return AppLocalizations.of(context)!.today;
  return DateFormat('EEEE', AppLocalizations.of(context)!.languageCode)
      .format(date);
}

String convertNumber(String n, {bool isInt = false}) {
  if (n.isEmpty) return '';
  double d = double.parse(n);
  if (isInt) {
    return NumberFormat.decimalPattern().format(d.toInt());
  }
  return NumberFormat.decimalPattern().format(d);
}

String sumNumber(String n1, String n2) {
  double d1 = n1.isNotEmpty ? double.parse(n1) : 0.0;
  double d2 = n2.isNotEmpty ? double.parse(n2) : 0.0;
  return NumberFormat.decimalPattern().format((d1 + d2).toInt());
}

String subNumber(String n1, String n2) {
  double d1 = n1.isNotEmpty ? double.parse(n1) : 0.0;
  double d2 = n2.isNotEmpty ? double.parse(n2) : 0.0;
  return NumberFormat.decimalPattern().format((d1 - d2).toInt());
}

String getDay(int d) {
  switch (d) {
    case 1:
      return 'T2';
    case 2:
      return 'T3';
    case 3:
      return 'T4';
    case 4:
      return 'T5';
    case 5:
      return 'T6';
    case 6:
      return 'T7';
    default:
      {
        return 'CN';
      }
  }
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

String capitalize(String s) {
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}

int checkShiftStatus(AttendanceModel attendanceModel) {
  DateTime now = DateTime.now();
  DateTime startShift =
      DateFormat("HH:mm:ss").parse(attendanceModel.startShift);
  DateTime endShift = DateFormat("HH:mm:ss").parse(attendanceModel.endShift);

  if (attendanceModel.day.isAfter(now)) {
    return 0; //chua den ca lam
  }
  if (attendanceModel.checkin == null && attendanceModel.checkin == null) {
    return 1; //chua vao/ra ca
  }

  if (attendanceModel.checkin != null && attendanceModel.checkin == null) {
    return 2; //chua ra ca
  }
  DateTime checkin = DateFormat("HH:mm:ss").parse(attendanceModel.checkin!);
  DateTime checkout = DateFormat("HH:mm:ss").parse(attendanceModel.checkout!);

  if (checkin.isAfter(startShift) || endShift.isAfter(checkout)) {
    return 3; //tre gio , ve som
  }
  return 4; //dung gio
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
