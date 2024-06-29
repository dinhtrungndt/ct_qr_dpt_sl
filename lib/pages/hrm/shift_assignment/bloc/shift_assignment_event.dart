part of 'shift_assignment_bloc.dart';

class ShiftAssignmentEvent extends Equatable {
  const ShiftAssignmentEvent();

  @override
  List<Object> get props => [];
}

class ShiftAssignmentInitialEvent extends ShiftAssignmentEvent {}

class ChooseShiftAssignmentEvent extends ShiftAssignmentEvent {
  final ShiftModel shiftModel;
  const ChooseShiftAssignmentEvent({required this.shiftModel});
}

class ChooseEmployeeEvent extends ShiftAssignmentEvent {
  final int employeeID;
  const ChooseEmployeeEvent({required this.employeeID});
}

class AddWorkPlanEvent extends ShiftAssignmentEvent {
  DateTime dateApply;
  AddWorkPlanEvent({required this.dateApply});
}

class DeleteWorkPlanEvent extends ShiftAssignmentEvent {
  DateTime dateApply;
  int shiftID;
  DeleteWorkPlanEvent({required this.dateApply, required this.shiftID});
}

class ChangeWeekEvent extends ShiftAssignmentEvent {
  int number;
  ChangeWeekEvent({required this.number});
}
