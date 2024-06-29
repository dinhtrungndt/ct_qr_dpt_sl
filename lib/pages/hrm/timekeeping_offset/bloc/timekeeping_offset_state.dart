part of 'timekeeping_offset_bloc.dart';

enum SendTimekeepingOffsetStatus { initial, lack, loading, success, failure }

@immutable
class TimekeepingOffsetState extends Equatable {
  final List<ShiftModel> listShiftModel;
  final ShiftModel? shiftModel;
  final DateTime? applyDate;
  final DateTime? fromTime;
  final DateTime? toTime;
  final SendTimekeepingOffsetStatus sendStatus;
  const TimekeepingOffsetState(
      {this.listShiftModel = const [],
      this.shiftModel,
      this.applyDate,
      this.fromTime,
      this.toTime,
      this.sendStatus = SendTimekeepingOffsetStatus.initial});

  TimekeepingOffsetState copyWith(
      {List<ShiftModel>? listShiftModel,
      ShiftModel? shiftModel,
      DateTime? applyDate,
      DateTime? fromTime,
      DateTime? toTime,
      SendTimekeepingOffsetStatus? sendStatus}) {
    return TimekeepingOffsetState(
      listShiftModel: listShiftModel ?? this.listShiftModel,
      shiftModel: shiftModel ?? this.shiftModel,
      applyDate: applyDate ?? this.applyDate,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
      sendStatus: sendStatus ?? this.sendStatus,
    );
  }

  @override
  List<Object?> get props =>
      [shiftModel, applyDate, fromTime, toTime, sendStatus];
}
