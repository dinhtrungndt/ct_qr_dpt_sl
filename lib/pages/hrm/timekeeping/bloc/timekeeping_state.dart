part of 'timekeeping_bloc.dart';

//import 'package:equatable/equatable.dart';
enum TimekeepingStatus { success, loading }

@immutable
class TimekeepingState extends Equatable {
  final List<AttendanceModel> listAttendanceModel;
  final List<TimeSheetModel> listTimeSheetModel;
  final DateTime? fromDate;
  final DateTime? toDate;
  final TimekeepingStatus status;

  const TimekeepingState(
      {this.listAttendanceModel = const [],
      this.listTimeSheetModel = const [],
      this.fromDate,
      this.toDate,
      this.status = TimekeepingStatus.success});
  TimekeepingState copyWith(
      {List<AttendanceModel>? listAttendanceModel,
      List<TimeSheetModel>? listTimeSheetModel,
      DateTime? fromDate,
      DateTime? toDate,
      int? nAttendanceInvalid,
      int? nOnLeave,
      int? nOffset,
      TimekeepingStatus? status}) {
    return TimekeepingState(
      listAttendanceModel: listAttendanceModel ?? this.listAttendanceModel,
      listTimeSheetModel: listTimeSheetModel ?? this.listTimeSheetModel,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [listAttendanceModel, listTimeSheetModel, status, fromDate, toDate];
}
