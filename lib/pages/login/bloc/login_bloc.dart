import 'package:bloc/bloc.dart';
import 'package:erp/model/server_model.dart';
import '../../../model/login_model.dart';
import '../../../network/api_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<VerifyServer>((event, emit) async {
      emit(VerifyServerWaiting());
      ServerModel? serverModel = await ApiProvider().verifyServer(event.url);
      if (serverModel != null) {
        Server.url = serverModel.url;
        Server.siteID = serverModel.siteID;
        emit(VerifyServerSuccess());
      } else {
        emit(VerifyServerFail());
      }
    });
    on<Login>(_login);
    on<SignUpEvent>(((event, emit) async {
      String? response = await ApiProvider().signUp(event.name, event.no_,
          event.password, event.saltValue, event.code, event.attendCode);
      if (response == "ADD") {
        emit(SignUpSuccess());
      } else {
        emit(SignUpFail(message: response));
      }
    }));
  }
}

void _login(Login event, Emitter<LoginState> emit) async {
  emit(LoginWaiting());
  LoginModel? data = await ApiProvider()
      .login(event.no_, event.password, event.site, event.apiToken);
  if (data != null) {
    emit(LoginSuccess(loginData: data));
  } else {
    emit(LoginError(errorMessage: "Tài khoản hoặc mật khẩu không đúng"));
  }
}
