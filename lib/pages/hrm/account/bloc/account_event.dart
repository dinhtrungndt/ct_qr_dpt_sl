part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class InitialAccountEvent extends AccountEvent {}

class SendAccountEvent extends AccountEvent {
  final String fullName;
  final String address;
  final String phone;
  const SendAccountEvent(
      {required this.fullName, required this.address, required this.phone});
}

class ChangeBirthDayEvent extends AccountEvent {
  DateTime birthDay;
  ChangeBirthDayEvent(this.birthDay);
}

class ChangeGenderEvent extends AccountEvent {
  bool gender;
  ChangeGenderEvent(this.gender);
}
