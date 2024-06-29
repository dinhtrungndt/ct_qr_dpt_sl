import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/login_model.dart';
import 'package:erp/network/api_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'account_manager_event.dart';
part 'account_manager_state.dart';

class AccountManagerBloc
    extends Bloc<AccountManagerEvent, AccountManagerState> {
  AccountManagerBloc() : super(AccountManagerInitial()) {
    on<ChangePasswordEvent>((event, emit) async {
      LoginModel? data =
          await ApiProvider().login(User.no_, event.oldPassword, 'KIA', '');
      if (data != null) {
        String response = await ApiProvider()
            .changePassword(event.newPassword, event.saltValue);
        if (response == 'UPDATE') {
          EasyLoading.showSuccess('Change password success');
          emit(ChangePasswordSuccess());
        } else {
          EasyLoading.showError('Change password fail');
          emit(ChangePasswordFail());
        }
      } else {
        EasyLoading.showError('Wrong password');
        emit(WrongPassword());
      }
    });
  }
}
