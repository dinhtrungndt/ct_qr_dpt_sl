import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/hrm_model/employee_model.dart';
import 'package:erp/network/api_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<SendAccountEvent>((event, emit) async {
      Map<String, dynamic> data = {
        'id': UserModel.id,
        'fullName': event.fullName,
        'address': event.address,
        'birthDay': state.birthDay!.toIso8601String(),
        'gender': state.gender,
        'phone': event.phone
      };
      String res = await ApiProvider().saveInfoEmployee(data);
      if (res == "OK") {
        EasyLoading.showSuccess("Save success");
      } else {
        EasyLoading.showError("Something is wrong");
      }
    });
    on<InitialAccountEvent>((event, emit) async {
      EmployeeModel employeeModel =
          await ApiProvider().getInfoEmployee(UserModel.id);
      if (employeeModel != null) {
        emit(AccountState(
          fullName: employeeModel.fullName,
          birthDay: employeeModel.birthDay,
          code: employeeModel.code,
          attendCode: employeeModel.attendCode,
          phone: employeeModel.phone,
          gender: employeeModel.gender,
          position: employeeModel.position,
          organization: employeeModel.organization,
          salary: employeeModel.salary,
        ));
      }
    });
    on<ChangeBirthDayEvent>((event, emit) async {
      emit(state.copyWith(
        birthDay: event.birthDay,
      ));
    });
    on<ChangeGenderEvent>((event, emit) async {
      emit(state.copyWith(
        gender: event.gender,
      ));
    });
  }
}
