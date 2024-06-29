part of 'account_manager_bloc.dart';

class AccountManagerState extends Equatable {
  const AccountManagerState();

  @override
  List<Object> get props => [];
}

class AccountManagerInitial extends AccountManagerState {}

class WrongPassword extends AccountManagerState {}

class ChangePasswordSuccess extends AccountManagerState {}

class ChangePasswordFail extends AccountManagerState {}
