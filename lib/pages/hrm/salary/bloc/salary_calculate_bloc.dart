import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../model/hrm_model/attendance_model.dart';
import '../../../../model/hrm_model/employee_model.dart';
import '../../../../model/hrm_model/salary_model.dart';
import '../../../../network/api_provider.dart';

part 'salary_calculate_event.dart';
part 'salary_calculate_state.dart';

class SalaryCalculateBloc
    extends Bloc<SalaryCalculateEvent, SalaryCalculateState> {
  SalaryCalculateBloc() : super(const SalaryCalculateState()) {
    on<InitialSalaryCalculateEvent>((event, emit) async {
      List<SalaryPeriodModel> listSalaryPeriodModel =
          await ApiProvider().getListSalaryPeriod();
      emit(SalaryCalculateState(listSalaryPeriodModel: listSalaryPeriodModel));
    });
    on<ChooseSalaryPeriod>((event, emit) async {
      emit(state.copyWith(status: SalaryCalculateStatus.loading));
      List<SalaryCalculateModel> listSalaryCalculateModel = await ApiProvider()
          .getSalaryCalculate(UserModel.id, event.salaryPeriod.id);
      if (listSalaryCalculateModel.length == 1) {
        emit(state.copyWith(
            salaryCalculateModel: listSalaryCalculateModel.first,
            salaryPeriodModel: event.salaryPeriod,
            status: SalaryCalculateStatus.success));
      } else {
        emit(state.copyWith(
            salaryPeriodModel: event.salaryPeriod,
            status: SalaryCalculateStatus.failure));
      }
    });
  }
}
