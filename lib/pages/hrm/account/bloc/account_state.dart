part of 'account_bloc.dart';

class AccountState extends Equatable {
  int? id;
  String? code;
  String? attendCode;
  String? fullName;
  String? address;
  String? phone;
  DateTime? birthDay;
  bool? gender;
  String? position;
  String? organization;
  int? salary;
  AccountState({
    this.id,
    this.code,
    this.attendCode,
    this.gender,
    this.fullName,
    this.birthDay,
    this.phone,
    this.address,
    this.position,
    this.organization,
    this.salary,
  });

  AccountState copyWith(
      {String? code,
      String? attendCode,
      String? fullName,
      DateTime? birthDay,
      String? address,
      String? phone,
      bool? gender,
      String? position,
      String? organization,
      int? salary}) {
    return AccountState(
        code: code ?? this.code,
        attendCode: attendCode ?? this.attendCode,
        fullName: fullName ?? this.fullName,
        birthDay: birthDay ?? this.birthDay,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        gender: gender ?? this.gender,
        position: position ?? this.position,
        organization: organization ?? this.organization,
        salary: salary ?? this.salary);
  }

  @override
  List<Object?> get props => [
        code,
        attendCode,
        fullName,
        birthDay,
        address,
        phone,
        gender,
        position,
        organization,
        salary
      ];
}

class AccountInitial extends AccountState {}

class AccountInfoState extends AccountState {
  final EmployeeModel infoEmployee;
  AccountInfoState({required this.infoEmployee});
}

class AccountInfoLoadState extends AccountState {}
