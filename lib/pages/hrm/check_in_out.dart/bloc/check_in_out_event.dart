part of 'check_in_out_bloc.dart';

abstract class CheckInOutEvent extends Equatable {
  const CheckInOutEvent();

  @override
  List<Object> get props => [];
}

class InitialCheckInOutEvent extends CheckInOutEvent {}

class CheckInOutLoadLocationEvent extends CheckInOutEvent {}

class CheckInOutConfirmEvent extends CheckInOutEvent {}

class ChooseLocationEvent extends CheckInOutEvent {
  final LocationModel location;
  const ChooseLocationEvent({required this.location});
}

class ChooseShiftEvent extends CheckInOutEvent {
  final ShiftModel shiftModel;
  const ChooseShiftEvent({required this.shiftModel});
}

class GetLocationEvent extends CheckInOutEvent {
  final Position currentPosition;
  const GetLocationEvent({required this.currentPosition});
}

class CheckInPostEvent extends CheckInOutEvent {
  final int id;
  final String employeeID;
  final String authDate;
  final String authTime;
  final int locationID;
  final String token;
  const CheckInPostEvent(
      {required this.id,
      required this.employeeID,
      required this.authDate,
      required this.authTime,
      required this.locationID,
      required this.token});
}
