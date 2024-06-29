import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';
import '../../../../model/hrm_model/attendance_model.dart';
import '../../../../model/hrm_model/employee_model.dart';
import '../../../../model/login_model.dart';
import '../../../../method/hrm_method.dart';
import '../../../../network/api_provider.dart';
part 'shift_calendar_event.dart';
part 'shift_calendar_state.dart';

class ShiftCalendarBloc extends Bloc<ShiftCalendarEvent, ShiftCalendarState> {
  ShiftCalendarBloc() : super(const ShiftCalendarState()) {
    on<ShiftCalendarLoadToday>((event, emit) async {
      emit(state.copyWith(loadStatus: LoadShiftCalendarStatus.loading));
      DateTime now = DateTime.now();
      List<AttendanceModel> list = await _getListAttendance(now, now);
      emit(state.copyWith(
          listAttendanceModel: list,
          fromDate: now,
          toDate: now,
          selectDateText:
              '${getDay(now.weekday)}, ${DateFormat('dd.MM').format(now)}',
          loadStatus: LoadShiftCalendarStatus.success));
    });

    on<ShiftCalendarLoadWeek>((event, emit) async {
      emit(state.copyWith(loadStatus: LoadShiftCalendarStatus.loading));
      DateTime now = DateTime.now();
      DateTime fromDate = now.subtract(Duration(days: now.weekday - 1));
      DateTime toDate = DateTime(fromDate.year, fromDate.month, fromDate.day)
          .add(const Duration(days: 6));
      List<AttendanceModel> list = await _getListAttendance(fromDate, toDate);
      emit(state.copyWith(
          listAttendanceModel: list,
          fromDate: fromDate,
          toDate: toDate,
          selectDateText:
              '${DateFormat('dd.MM').format(fromDate)} - ${DateFormat('dd.MM').format(toDate)}',
          loadStatus: LoadShiftCalendarStatus.success));
    });

    on<ShiftCalendarLoadMonth>((event, emit) async {
      emit(state.copyWith(loadStatus: LoadShiftCalendarStatus.loading));
      DateTime now = DateTime.now();
      int numberDay = daysInMonth(now);
      DateTime fromDate = DateTime(now.year, now.month, 1);
      DateTime toDate = DateTime(now.year, now.month, numberDay);
      List<AttendanceModel> list = await _getListAttendance(fromDate, toDate);
      emit(state.copyWith(
          listAttendanceModel: list,
          fromDate: fromDate,
          toDate: toDate,
          selectDateText:
              '${DateFormat('dd.MM').format(fromDate)} - ${DateFormat('dd.MM').format(toDate)}',
          loadStatus: LoadShiftCalendarStatus.success));
    });

    on<ShiftCalendarLoadRangeDate>((event, emit) async {
      emit(state.copyWith(loadStatus: LoadShiftCalendarStatus.loading));
      List<AttendanceModel> list =
          await _getListAttendance(event.fromDate, event.toDate);
      emit(state.copyWith(
          listAttendanceModel: list,
          fromDate: event.fromDate,
          toDate: event.toDate,
          selectDateText:
              '${DateFormat('dd.MM').format(event.fromDate)} - ${DateFormat('dd.MM').format(event.toDate)}',
          loadStatus: LoadShiftCalendarStatus.success));
    });
  }
}

Future<List<AttendanceModel>> _getListAttendance(
    DateTime fromDate, DateTime toDate) async {
  Map<String, dynamic> data = {
    'employeeId': UserModel.id,
    'fromDate': DateFormat('yyyy-MM-dd').format(fromDate),
    'toDate': DateFormat('yyyy-MM-dd').format(toDate)
  };
  List<AttendanceModel> list = await ApiProvider().getListAttendance(data);
  return list;
}
