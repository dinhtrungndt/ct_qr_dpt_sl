part of 'timekeeping_bloc.dart';

@immutable
class TimekeepingEvent extends Equatable {
  const TimekeepingEvent();
  @override
  List<Object> get props => [];
}

class InitialTimekeepingEvent extends TimekeepingEvent {}

class ChooseDateRangeEvent extends TimekeepingEvent {
  final DateTime fromDate;
  final DateTime toDate;
  const ChooseDateRangeEvent({required this.fromDate, required this.toDate});
}
