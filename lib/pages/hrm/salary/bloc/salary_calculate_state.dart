part of 'salary_calculate_bloc.dart';

enum SalaryCalculateStatus { success, loading, failure }

class SalaryCalculateState extends Equatable {
  final List<SalaryPeriodModel> listSalaryPeriodModel;
  final SalaryPeriodModel? salaryPeriodModel;
  final SalaryCalculateModel? salaryCalculateModel;
  final SalaryCalculateStatus status;

  const SalaryCalculateState(
      {this.listSalaryPeriodModel = const [],
      this.salaryPeriodModel,
      this.salaryCalculateModel,
      this.status = SalaryCalculateStatus.success});
  SalaryCalculateState copyWith(
      {List<SalaryPeriodModel>? listSalaryPeriodModel,
      SalaryPeriodModel? salaryPeriodModel,
      SalaryCalculateModel? salaryCalculateModel,
      SalaryCalculateStatus? status}) {
    return SalaryCalculateState(
      listSalaryPeriodModel:
          listSalaryPeriodModel ?? this.listSalaryPeriodModel,
      salaryPeriodModel: salaryPeriodModel ?? this.salaryPeriodModel,
      salaryCalculateModel: salaryCalculateModel ?? this.salaryCalculateModel,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [salaryPeriodModel, salaryCalculateModel, status];
}
