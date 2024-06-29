part of 'shift_calendar_bloc.dart';

@immutable
class ShiftCalendarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ShiftCalendarLoadToday extends ShiftCalendarEvent {}

class ShiftCalendarLoadMonth extends ShiftCalendarEvent {}

class ShiftCalendarLoadWeek extends ShiftCalendarEvent {}

class ShiftCalendarLoadRangeDate extends ShiftCalendarEvent {
  final DateTime fromDate;
  final DateTime toDate;
  ShiftCalendarLoadRangeDate({required this.fromDate, required this.toDate});
  @override
  List<Object> get props => [fromDate, toDate];
}
