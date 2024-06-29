part of 'shift_calendar_bloc.dart';

//import 'package:equatable/equatable.dart';
enum LoadShiftCalendarStatus { loading, success, failure }

@immutable
class ShiftCalendarState extends Equatable {
  final List<AttendanceModel> listAttendanceModel;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String selectDateText;
  final LoadShiftCalendarStatus loadStatus;
  const ShiftCalendarState(
      {this.listAttendanceModel = const [],
      this.fromDate,
      this.toDate,
      this.selectDateText = '',
      this.loadStatus = LoadShiftCalendarStatus.success});
  ShiftCalendarState copyWith(
      {List<AttendanceModel>? listAttendanceModel,
      DateTime? fromDate,
      DateTime? toDate,
      String? selectDateText,
      LoadShiftCalendarStatus? loadStatus}) {
    return ShiftCalendarState(
        listAttendanceModel: listAttendanceModel ?? this.listAttendanceModel,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
        selectDateText: selectDateText ?? this.selectDateText,
        loadStatus: loadStatus ?? this.loadStatus);
  }

  @override
  List<Object> get props => [listAttendanceModel, selectDateText,loadStatus];
}
