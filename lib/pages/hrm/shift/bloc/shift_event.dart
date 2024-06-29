part of 'shift_bloc.dart';

class ShiftEvent extends Equatable {
  const ShiftEvent();

  @override
  List<Object> get props => [];
}

class ShiftInitial extends ShiftEvent {}

class ChooseFromTimeEvent extends ShiftEvent {
  final DateTime fromTime;
  const ChooseFromTimeEvent({required this.fromTime});
}

class ChooseToTimeEvent extends ShiftEvent {
  final DateTime toTime;
  const ChooseToTimeEvent({required this.toTime});
}

class ChooseStartBreakEvent extends ShiftEvent {
  final DateTime startBreak;
  const ChooseStartBreakEvent({required this.startBreak});
}

class ChooseEndBreakEvent extends ShiftEvent {
  final DateTime endBreak;
  const ChooseEndBreakEvent({required this.endBreak});
}

class SendShiftEvent extends ShiftEvent {
  final int? id;
  final String code;
  final String title;
  const SendShiftEvent(
      {required this.id, required this.code, required this.title});
}

class ResetStateEvent extends ShiftEvent {}

class EditShiftEvent extends ShiftEvent {
  final ShiftModel model;
  const EditShiftEvent({required this.model});
}
