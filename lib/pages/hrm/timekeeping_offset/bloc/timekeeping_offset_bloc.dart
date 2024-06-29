import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/hrm_model/request_management_model.dart';
import 'package:flutter/material.dart';
import '../../../../model/hrm_model/employee_model.dart';
import '../../../../model/hrm_model/shift_model.dart';
import '../../../../model/login_model.dart';
import '../../../../network/api_provider.dart';
part 'timekeeping_offset_event.dart';
part 'timekeeping_offset_state.dart';

class TimekeepingOffsetBloc
    extends Bloc<TimekeepingOffsetEvent, TimekeepingOffsetState> {
  TimekeepingOffsetBloc() : super(const TimekeepingOffsetState()) {
    on<InitialTimekeepingOffsetEvent>((event, emit) async {
      List<ShiftModel> listShiftModel = await ApiProvider().getListShiftModel();
      if (event.timekeepingOffsetModel != null) {
        ShiftModel shiftModel = listShiftModel
            .firstWhere((e) => e.id == event.timekeepingOffsetModel?.shiftID);
        emit(TimekeepingOffsetState(
            applyDate: event.timekeepingOffsetModel?.dateApply,
            fromTime: event.timekeepingOffsetModel?.fromTime,
            toTime: event.timekeepingOffsetModel?.toTime,
            shiftModel: shiftModel,
            listShiftModel: listShiftModel));
      } else {
        emit(TimekeepingOffsetState(listShiftModel: listShiftModel));
      }
    });
    on<ChooseTimekeepingOffsetShiftEvent>((event, emit) {
      emit(state.copyWith(
          shiftModel: event.shiftModel,
          sendStatus: SendTimekeepingOffsetStatus.initial));
    });
    on<ChooseApplyDateEvent>((event, emit) {
      emit(state.copyWith(
          applyDate: event.applyDate,
          sendStatus: SendTimekeepingOffsetStatus.initial));
    });
    on<ChooseFromTimeEvent>((event, emit) {
      emit(state.copyWith(
          fromTime: event.fromTime,
          sendStatus: SendTimekeepingOffsetStatus.initial));
    });
    on<ChooseToTimeEvent>((event, emit) {
      emit(state.copyWith(
          toTime: event.toTime,
          sendStatus: SendTimekeepingOffsetStatus.initial));
    });
    on<SendTimekeepingOffsetEvent>((event, emit) async {
      if (state.sendStatus == SendTimekeepingOffsetStatus.loading) return;
      if (state.shiftModel == null || state.applyDate == null) {
        emit(state.copyWith(sendStatus: SendTimekeepingOffsetStatus.lack));
        emit(state.copyWith(sendStatus: SendTimekeepingOffsetStatus.initial));
        return;
      }
      emit(state.copyWith(sendStatus: SendTimekeepingOffsetStatus.loading));
      Map<String, dynamic> data = {
        'id': event.id,
        'shiftID': state.shiftModel!.id,
        'employeeID': UserModel.id, //8758,
        'dateApply': state.applyDate!.toIso8601String(),
        'fromTime': state.fromTime!.toIso8601String(),
        'toTime': state.toTime!.toIso8601String(),
        'createBy': User.no_,
        'status': 0,
        'reason': event.reason,
        'note': event.note,
        'siteID': UserModel.siteName,
      };
      String result = await ApiProvider().sendTimekeepingOffsetRequest(data);
      if (result == "ADD" || result == "UPDATE") {
        emit(state.copyWith(sendStatus: SendTimekeepingOffsetStatus.success));
      } else {
        emit(state.copyWith(sendStatus: SendTimekeepingOffsetStatus.failure));
        emit(state.copyWith(sendStatus: SendTimekeepingOffsetStatus.initial));
      }
    });
  }
}
