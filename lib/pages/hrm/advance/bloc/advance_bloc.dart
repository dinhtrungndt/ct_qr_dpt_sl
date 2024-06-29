import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../model/hrm_model/advance_model.dart';
import '../../../../model/hrm_model/employee_model.dart';
import '../../../../model/login_model.dart';
import '../../../../method/hrm_method.dart';
import '../../../../network/api_provider.dart';

part 'advance_event.dart';
part 'advance_state.dart';

class AdvanceBloc extends Bloc<AdvanceEvent, AdvanceState> {
  AdvanceBloc() : super(const AdvanceState()) {
    on<InitialAdvanceEvent>((event, emit) async {
      List<AdvanceKindModel> listAdvanceKindModel =
          await ApiProvider().getListAdvanceKind();
      emit(AdvanceState(listAdvanceKindModel: listAdvanceKindModel));
    });
    on<ChooseAdvanceKindEvent>((event, emit) {
      emit(state.copyWith(
          advanceKindModel: event.advanceKind,
          sendStatus: SendAdvanceStatus.initial));
    });
    on<ChooseAdvanceFromDateEvent>((event, emit) {
      emit(state.copyWith(
          fromDate: event.fromDate, sendStatus: SendAdvanceStatus.initial));
    });
    on<ChooseAdvanceToDateEvent>((event, emit) {
      emit(state.copyWith(
          toDate: event.toDate, sendStatus: SendAdvanceStatus.initial));
    });
    on<SendAdvanceEvent>((event, emit) async {
      if (state.sendStatus == SendAdvanceStatus.loading) return;
      if (state.advanceKindModel == null ||
          state.fromDate == null ||
          state.toDate == null ||
          event.note.isEmpty ||
          event.money.isEmpty) {
        emit(state.copyWith(
            sendStatus: SendAdvanceStatus.failure,
            error: 'Vui lòng điền đầy đủ thông tin'));
        emit(state.copyWith(sendStatus: SendAdvanceStatus.initial, error: ''));
        return;
      }
      if (daysBetween(state.fromDate!, state.toDate!) < 0) {
        emit(state.copyWith(
            sendStatus: SendAdvanceStatus.failure,
            error: 'Ngày kết thúc không hợp lệ'));
        emit(state.copyWith(sendStatus: SendAdvanceStatus.initial, error: ''));
        return;
      }
      emit(state.copyWith(sendStatus: SendAdvanceStatus.loading));

      Map<String, dynamic> data = {
        'ID': 0,
        'Code': '',
        'Reduce': state.advanceKindModel!.id,
        'Qty': event.money.replaceAll('.', ''),
        'EmployeeID': UserModel.id, //8758,
        'EffectFrom': state.fromDate!.toIso8601String(),
        'EffectTo': state.toDate!.toIso8601String(),
        'CreateBy': User.name,
        'UpdateBy': User.name,
        'Status': 0,
        'SiteID': UserModel.siteName,
        'Description': event.note
      };
      String? result = await ApiProvider().sendAdvanceRequest(data);
      if (result != null) {
        emit(state.copyWith(sendStatus: SendAdvanceStatus.success, error: ''));
      } else {
        emit(state.copyWith(
            sendStatus: SendAdvanceStatus.failure,
            error: 'Đã gửi yêu cầu thất bại'));
        emit(state.copyWith(sendStatus: SendAdvanceStatus.initial, error: ''));
      }
    });
  }
}
