import 'package:bloc/bloc.dart';
import 'package:erp/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';
import '../../../../model/hrm_model/attendance_model.dart';
import '../../../../model/hrm_model/employee_model.dart';
import '../../../../network/api_provider.dart';
part 'timekeeping_event.dart';
part 'timekeeping_state.dart';

class TimekeepingBloc extends Bloc<TimekeepingEvent, TimekeepingState> {
  TimekeepingBloc() : super(const TimekeepingState()) {
    on<InitialTimekeepingEvent>((event, emit) async {
      emit(state.copyWith(fromDate: null, toDate: null));
    });

    on<ChooseDateRangeEvent>((event, emit) async {
      emit(state.copyWith(status: TimekeepingStatus.loading));
      List<AttendanceModel> listAttendanceModel =
          await _getListAttendance(event.fromDate, event.toDate);

      emit(state.copyWith(
          listAttendanceModel: listAttendanceModel,
          fromDate: event.fromDate,
          toDate: event.toDate,
          status: TimekeepingStatus.success));
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
  return list.reversed.toList();
}

Future<int> _getListAttendanceInvalid(
    DateTime fromDate, DateTime toDate) async {
  Map<String, dynamic> data = {
    'deptId': 0,
    'empCode': UserModel.id.toString(),
    'fromDate': DateFormat('yyyy-MM-dd').format(fromDate),
    'toDate': DateFormat('yyyy-MM-dd').format(toDate)
  };
  return await ApiProvider().getListAttendanceInvalid(data);
}

Future<List<TimeSheetModel>> _getTimeSheets(int periodId) async {
  Map<String, dynamic> data = {
    'listEmpId': [UserModel.id],
    'period': periodId,
    'siteID': UserModel.siteName
  };
  return await ApiProvider().getTimeSheets(data);
}

Future<List<SummaryOffsetModel>> _getOffsetAndOnLeave(int periodId) async {
  Map<String, dynamic> data = {
    'listEmpId': [UserModel.id],
    'period': periodId,
    'siteID': UserModel.siteName
  };
  return await ApiProvider().getOffsetAndOnLeave(data);
}
