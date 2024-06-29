import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/hrm_model/request_management_model.dart';

import '../../../../model/hrm_model/employee_model.dart';
import '../../../../model/hrm_model/on_leave_model.dart';
import '../../../../model/login_model.dart';
import '../../../../method/hrm_method.dart';
import '../../../../network/api_provider.dart';

part 'on_leave_event.dart';
part 'on_leave_state.dart';

class OnLeaveBloc extends Bloc<OnLeaveEvent, OnLeaveState> {
  OnLeaveBloc() : super(const OnLeaveState()) {
    //on<OnLeaveEvent>((event, emit) {});
    on<InitialOnLeaveEvent>((event, emit) async {
      List<OnLeaveKindModel> listOnLeaveKindModel =
          await ApiProvider().getListOnLeaveKind();
      if (event.model != null) {
        OnLeaveKindModel onLeaveKind = listOnLeaveKindModel
            .firstWhere((e) => e.id == event.model!.permissionType);
        emit(state.copyWith(
            listOnLeaveKindModel: listOnLeaveKindModel,
            onLeaveKindModel: onLeaveKind,
            fromDate: event.model!.fromDate,
            toDate: event.model!.toDate,
            expirationDate: event.model!.expired,
            sendStatus: SendOnLeaveStatus.initial,
            error: ''));
      } else {
        emit(OnLeaveState(listOnLeaveKindModel: listOnLeaveKindModel));
      }
    });
    on<ChooseOnLeaveKindEvent>((event, emit) {
      emit(state.copyWith(
          onLeaveKindModel: event.onLeaveKind,
          sendStatus: SendOnLeaveStatus.initial));
    });
    on<ChooseExpirationDateEvent>((event, emit) {
      emit(state.copyWith(
          expirationDate: event.expirationDate,
          sendStatus: SendOnLeaveStatus.initial));
    });
    on<ChooseFromDateEvent>((event, emit) {
      emit(state.copyWith(
          fromDate: event.fromDate, sendStatus: SendOnLeaveStatus.initial));
    });
    on<ChooseToDateEvent>((event, emit) {
      emit(state.copyWith(
          toDate: event.toDate, sendStatus: SendOnLeaveStatus.initial));
    });
    on<SendOnLeaveEvent>((event, emit) async {
      if (state.sendStatus == SendOnLeaveStatus.loading) return;
      if (state.onLeaveKindModel == null ||
          state.expirationDate == null ||
          state.fromDate == null ||
          state.toDate == null) {
        emit(state.copyWith(sendStatus: SendOnLeaveStatus.failure, error: '1'));
        emit(state.copyWith(sendStatus: SendOnLeaveStatus.initial, error: ''));
        return;
      }
      if (daysBetween(state.fromDate!, state.toDate!) < 0) {
        emit(state.copyWith(sendStatus: SendOnLeaveStatus.failure, error: '2'));
        emit(state.copyWith(sendStatus: SendOnLeaveStatus.initial, error: ''));
        return;
      }
      emit(state.copyWith(sendStatus: SendOnLeaveStatus.loading));
      OnLeaveProfileModel onLeaveProfile =
          await ApiProvider().getOnLeaveProfile();
      if (onLeaveProfile.surplus + 2 < event.qty &&
          state.onLeaveKindModel!.id == 21) {
        emit(state.copyWith(sendStatus: SendOnLeaveStatus.failure, error: '3'));
      } else if (event.qty <= 2 + onLeaveProfile.surplus &&
          state.onLeaveKindModel!.id == 21) {
        emit(state.copyWith(sendStatus: SendOnLeaveStatus.failure, error: '4'));
      } else {
        Map<String, dynamic> data = {
          'id': event.id,
          'permissionType': state.onLeaveKindModel!.id,
          'employeeID': UserModel.id, //8758,
          'expired': state.expirationDate!.toIso8601String(),
          'fromDate': state.fromDate!.toIso8601String(),
          'toDate': state.toDate!.toIso8601String(),
          'qty': event.qty,
          'status': 0,
          'siteID': UserModel.siteName,
          'description': event.note,
          'year': DateTime.now().year,
          'docType': 'OLDocType',
          'createBy': User.no_
        };
        String result = await ApiProvider().sendOnLeaveRequest(data);
        if (result == "ADD" || result == "UPDATE") {
          emit(
              state.copyWith(sendStatus: SendOnLeaveStatus.success, error: ''));
        } else {
          emit(state.copyWith(
              sendStatus: SendOnLeaveStatus.failure,
              error: 'Đã gửi yêu cầu thất bại'));
          emit(
              state.copyWith(sendStatus: SendOnLeaveStatus.initial, error: ''));
        }
      }
    });
    on<ConfirmAdvanceOnLeaveEvent>((event, emit) async {
      emit(state.copyWith(sendStatus: SendOnLeaveStatus.loading));
      Map<String, dynamic> data = {
        'id': event.id,
        'permissionType': state.onLeaveKindModel!.id,
        'employeeID': UserModel.id, //8758,
        'expired': state.expirationDate!.toIso8601String(),
        'fromDate': state.fromDate!.toIso8601String(),
        'toDate': state.toDate!.toIso8601String(),
        'qty': event.qty,
        'status': 0,
        'siteID': UserModel.siteName,
        'description': event.note,
        'year': DateTime.now().year,
        'docType': 'OLDocType',
        'createBy': User.no_
      };
      String result = await ApiProvider().sendOnLeaveRequest(data);
      if (result == "ADD") {
        emit(state.copyWith(sendStatus: SendOnLeaveStatus.success, error: ''));
      } else {
        emit(state.copyWith(
            sendStatus: SendOnLeaveStatus.failure,
            error: 'Đã gửi yêu cầu thất bại'));
        emit(state.copyWith(sendStatus: SendOnLeaveStatus.initial, error: ''));
      }
    });
  }
}

int getTotalDay(DateTime fromDate, DateTime toDate) {
  int totalDay = daysBetween(fromDate, toDate);
  if (totalDay >= 0) totalDay += 1;
  if (totalDay == 1) {
    // onDay.value = 1;
  } else {
    //onDay.value = 0;
  }
  return totalDay;
}
