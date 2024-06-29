part of 'work_bloc.dart';

abstract class WorkEvent extends Equatable {
  const WorkEvent();
  @override
  List<Object> get props => [];
}

class InitialWorkEvent extends WorkEvent {}

class CheckInEvent extends WorkEvent {
}

class CheckOutEvent extends WorkEvent {}
