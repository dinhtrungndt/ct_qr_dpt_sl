import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/hrm_model/shift_model.dart';
import 'package:erp/model/login_model.dart';
import 'package:erp/network/api_provider.dart';
import 'package:flutter/material.dart';

part 'shift_event.dart';
part 'shift_state.dart';

class ShiftBloc extends Bloc<ShiftEvent, ShiftState> {
  ShiftBloc() : super(const ShiftState()) {
    on<ShiftInitial>((event, emit) async {
      List<ShiftModel> listShiftModel = await ApiProvider().getListShiftModel();
      emit(ShiftState(listShiftModel: listShiftModel));
    });
    on<ResetStateEvent>((event, emit) async {
      List<ShiftModel> listShiftModel = await ApiProvider().getListShiftModel();
      emit(ShiftState(listShiftModel: listShiftModel));
    });
    on<EditShiftEvent>((event, emit) {
      emit(state.copyWith(
        fromTime: event.model.fromTime,
        toTime: event.model.toTime,
        startBreak: event.model.startBreak,
        endBreak: event.model.endBreak,
      ));
    });
    on<ChooseFromTimeEvent>((event, emit) async {
      emit(state.copyWith(fromTime: event.fromTime));
    });
    on<ChooseToTimeEvent>((event, emit) async {
      emit(state.copyWith(toTime: event.toTime));
    });
    on<ChooseStartBreakEvent>((event, emit) async {
      emit(state.copyWith(startBreak: event.startBreak));
    });
    on<ChooseEndBreakEvent>((event, emit) async {
      emit(state.copyWith(endBreak: event.endBreak));
    });
    on<SendShiftEvent>((event, emit) async {
      int workMinute = state.toTime!.difference(state.fromTime!).inMinutes;
      Map<String, dynamic> data = {
        'id': event.id,
        'code': event.code,
        'title': event.title,
        'fromTime': state.fromTime?.toIso8601String(),
        'toTime': state.toTime?.toIso8601String(),
        'startBreak': state.startBreak?.toIso8601String(),
        'endBreak': state.endBreak?.toIso8601String(),
        'workTime': (workMinute / 60).toDouble(),
        'timeCalculate': (workMinute / 60).toDouble(),
        'createdBy': User.no_,
        'status': 0,
        'shiftType': 10,
        'coefficient': 1,
        'siteID': User.no_,
      };
      String res = await ApiProvider().addShiftModel(data);
      if (res == 'OK') {
        emit(state.copyWith(sendStatus: ShiftStatus.success));
      } else {
        emit(state.copyWith(sendStatus: ShiftStatus.failure));
      }
    });
  }
}
