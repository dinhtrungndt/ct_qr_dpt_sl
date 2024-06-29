import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/hrm_model/company_model.dart';
import 'package:flutter/material.dart';

import '../../../../model/hrm_model/shift_model.dart';
import '../../../../network/api_provider.dart';

part 'work_event.dart';
part 'work_state.dart';

class WorkBloc extends Bloc<WorkEvent, WorkState> {
  WorkBloc() : super(const WorkState()) {
    on<InitialWorkEvent>((event, emit) async {
      emit(const WorkState(status: WorkCheckInOutStatus.loading));
      bool checkInStatus = await ApiProvider().getCheckInStatus();
      WorkCheckInOutStatus status = WorkCheckInOutStatus.initial;
      ShiftModel? model;
      if (checkInStatus) {
        status = WorkCheckInOutStatus.checkIn;
        model = await ApiProvider().getCheckInShift();
      }
      emit(WorkState(status: status, shiftModel: model));
    });
    on<CheckInEvent>((event, emit) {
      emit(const WorkState(status: WorkCheckInOutStatus.checkIn));
    });
    on<CheckOutEvent>((event, emit) {
      emit(const WorkState(
          status: WorkCheckInOutStatus.initial, shiftModel: null));
      CompanyModel.shiftModel = null;
      CompanyModel.checkInStatus = false;
    });
  }
}
