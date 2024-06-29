part of 'advance_bloc.dart';

abstract class AdvanceEvent extends Equatable {
  const AdvanceEvent();

  @override
  List<Object> get props => [];
}

class InitialAdvanceEvent extends AdvanceEvent {}

class ChooseAdvanceKindEvent extends AdvanceEvent {
  final AdvanceKindModel advanceKind;
  const ChooseAdvanceKindEvent({required this.advanceKind});
}

class ChooseAdvanceFromDateEvent extends AdvanceEvent {
  final DateTime fromDate;
  const ChooseAdvanceFromDateEvent({required this.fromDate});
}

class ChooseAdvanceToDateEvent extends AdvanceEvent {
  final DateTime toDate;
  const ChooseAdvanceToDateEvent({required this.toDate});
}

class SendAdvanceEvent extends AdvanceEvent {
  final String money;
  final String note;
  const SendAdvanceEvent({required this.money, required this.note});
}
