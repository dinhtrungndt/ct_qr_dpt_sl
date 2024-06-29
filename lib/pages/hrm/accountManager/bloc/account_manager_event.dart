part of 'account_manager_bloc.dart';

class AccountManagerEvent extends Equatable {
  const AccountManagerEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordEvent extends AccountManagerEvent {
  String oldPassword;
  String newPassword;
  String saltValue;
  ChangePasswordEvent(
      {required this.oldPassword,
      required this.newPassword,
      required this.saltValue});
}
