part of 'shift_assignment_bloc.dart';

enum Status { initial, lack, loading, saveSuccess, failure, deleteSuccess }

class ShiftAssignmentState extends Equatable {
  final List<ShiftModel> listShiftModel;
  final List<WorkPlanModel> listWorkPlanModel;
  final ShiftModel? shiftModel;
  final int? employeeID;
  final DateTime? day;
  final DateTime? first;
  final DateTime? last;
  final DateTime? applyDate;
  final Status status;
  const ShiftAssignmentState(
      {this.listShiftModel = const [],
      this.listWorkPlanModel = const [],
      this.shiftModel,
      this.employeeID,
      this.day,
      this.first,
      this.last,
      this.applyDate,
      this.status = Status.initial});

  ShiftAssignmentState copyWith(
      {List<ShiftModel>? listShiftModel,
      List<WorkPlanModel>? listWorkPlanModel,
      ShiftModel? shiftModel,
      int? employeeID,
      DateTime? day,
      DateTime? first,
      DateTime? last,
      DateTime? applyDate,
      Status? status}) {
    return ShiftAssignmentState(
      listShiftModel: listShiftModel ?? this.listShiftModel,
      listWorkPlanModel: listWorkPlanModel ?? this.listWorkPlanModel,
      shiftModel: shiftModel ?? this.shiftModel,
      employeeID: employeeID ?? this.employeeID,
      day: day ?? this.day,
      first: first ?? this.first,
      last: last ?? this.last,
      applyDate: applyDate ?? this.applyDate,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [shiftModel, applyDate, status, employeeID, day];
}

class ShiftAssignmentInitial extends ShiftAssignmentState {}
