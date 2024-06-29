part of 'work_bloc.dart';

enum WorkCheckInOutStatus { initial, loading, checkIn }

@immutable
class WorkState extends Equatable {
  final ShiftModel? shiftModel;
  final WorkCheckInOutStatus status;
  const WorkState(
      {this.shiftModel, this.status = WorkCheckInOutStatus.initial});

  WorkState copyWith({
    ShiftModel? shiftModel,
    bool? checkIn,
    WorkCheckInOutStatus? status,
  }) {
    return WorkState(
        shiftModel: shiftModel ?? this.shiftModel,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [shiftModel, status];
}
