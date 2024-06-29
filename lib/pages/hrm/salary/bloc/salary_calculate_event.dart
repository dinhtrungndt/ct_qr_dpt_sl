part of 'salary_calculate_bloc.dart';

abstract class SalaryCalculateEvent extends Equatable {
  const SalaryCalculateEvent();

  @override
  List<Object> get props => [];
}

class InitialSalaryCalculateEvent extends SalaryCalculateEvent {}

class ChooseSalaryPeriod extends SalaryCalculateEvent {
  final SalaryPeriodModel salaryPeriod;
  const ChooseSalaryPeriod({required this.salaryPeriod});
  @override
  List<Object> get props => [salaryPeriod];
}
