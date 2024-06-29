part of 'timekeeping_offset_bloc.dart';

@immutable
abstract class TimekeepingOffsetEvent extends Equatable {
  //const TimekeepingOffsetEvent({required this.payload});
  //final dynamic payload;

  @override
  List<Object> get props => [];
}

class InitialTimekeepingOffsetEvent extends TimekeepingOffsetEvent {
  TimekeepingOffsetRequestModel? timekeepingOffsetModel;
  InitialTimekeepingOffsetEvent({this.timekeepingOffsetModel});
}

class SendTimekeepingOffsetEvent extends TimekeepingOffsetEvent {
  int? id;
  final String reason;
  final String note;
  SendTimekeepingOffsetEvent(
      {required this.id, required this.reason, required this.note});
}

class ChooseTimekeepingOffsetShiftEvent extends TimekeepingOffsetEvent {
  final ShiftModel shiftModel;
  ChooseTimekeepingOffsetShiftEvent({required this.shiftModel});
}

class ChooseApplyDateEvent extends TimekeepingOffsetEvent {
  final DateTime applyDate;
  ChooseApplyDateEvent({required this.applyDate});
}

class ChooseFromTimeEvent extends TimekeepingOffsetEvent {
  final DateTime fromTime;
  ChooseFromTimeEvent({required this.fromTime});
}

class ChooseToTimeEvent extends TimekeepingOffsetEvent {
  final DateTime toTime;
  ChooseToTimeEvent({required this.toTime});
}
