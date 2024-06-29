part of 'shift_bloc.dart';

enum ShiftStatus { initial, lack, loading, success, failure }

@immutable
class ShiftState extends Equatable {
  final List<ShiftModel> listShiftModel;
  final ShiftModel? shiftModel;
  final String code;
  final String title;
  final DateTime? fromTime;
  final DateTime? toTime;
  final DateTime? startBreak;
  final DateTime? endBreak;
  final ShiftStatus sendStatus;
  const ShiftState(
      {this.listShiftModel = const [],
      this.shiftModel,
      this.code = '',
      this.title = '',
      this.fromTime,
      this.toTime,
      this.startBreak,
      this.endBreak,
      this.sendStatus = ShiftStatus.initial});

  ShiftState copyWith(
      {List<ShiftModel>? listShiftModel,
      ShiftModel? shiftModel,
      String? code,
      String? title,
      DateTime? fromTime,
      DateTime? toTime,
      DateTime? startBreak,
      DateTime? endBreak,
      ShiftStatus? sendStatus = ShiftStatus.initial}) {
    return ShiftState(
        listShiftModel: listShiftModel ?? this.listShiftModel,
        shiftModel: shiftModel ?? this.shiftModel,
        code: code ?? this.code,
        title: title ?? this.title,
        fromTime: fromTime ?? this.fromTime,
        toTime: toTime ?? this.toTime,
        startBreak: startBreak ?? this.startBreak,
        endBreak: endBreak ?? this.endBreak,
        sendStatus: sendStatus ?? this.sendStatus);
  }

  @override
  List<Object?> get props => [
        shiftModel,
        code,
        title,
        fromTime,
        toTime,
        startBreak,
        endBreak,
        sendStatus
      ];
}
