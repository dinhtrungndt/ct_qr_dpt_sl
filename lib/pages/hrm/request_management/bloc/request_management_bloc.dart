import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/hrm_model/attendance_model.dart';
import 'package:erp/model/login_model.dart';
import 'package:flutter/material.dart';
import '../../../../model/hrm_model/employee_model.dart';
import '../../../../model/hrm_model/request_management_model.dart';
import '../../../../network/api_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
part 'request_management_event.dart';
part 'request_management_state.dart';

class RequestManagementBloc
    extends Bloc<RequestManagementEvent, RequestManagementState> {
  RequestManagementBloc() : super(const RequestManagementState()) {
    on<InitialRequestManagementEvent>((event, emit) async {
      DateTime now = DateTime.now();
      DateTime fromDate = now.subtract(Duration(days: now.weekday - 1));
      DateTime toDate = DateTime(fromDate.year, fromDate.month, fromDate.day)
          .add(const Duration(days: 6));
      emit(state.copyWith(status: RequestManagementStatus.loading));
      List<dynamic> listRequestAll = [];
      List<dynamic> listRequestNew = [];
      List<dynamic> listRequestApprove = [];
      List<dynamic> listRequestReject = [];
      listRequestAll
          .addAll(await _getListTimekeepingOffsetRequest(fromDate, toDate));
      listRequestAll.addAll(await _getListOnLeaveRequest(fromDate, toDate));
      listRequestAll.addAll(await _getListAdvanceRequest());
      for (var request in listRequestAll) {
        if (request.decision == 0) {
          listRequestNew.add(request);
        } else if (request.decision == 3) {
          listRequestApprove.add(request);
        } else if (request.decision == 4) {
          listRequestReject.add(request);
        }
      }
      emit(state.copyWith(
          fromDate: fromDate,
          toDate: toDate,
          listRequestNew: listRequestNew,
          listRequestApprove: listRequestApprove,
          listRequestReject: listRequestReject,
          status: RequestManagementStatus.success));
    });
    on<RequestManagementLoadEvent>((event, emit) async {
      if (state.fromDate != null) {
        emit(state.copyWith(status: RequestManagementStatus.loading));
        DateTime? fromDate = state.fromDate!;
        DateTime? toDate = state.toDate!;
        List<dynamic> listRequestAll = [];
        List<dynamic> listRequestNew = [];
        List<dynamic> listRequestApprove = [];
        List<dynamic> listRequestReject = [];
        listRequestAll
            .addAll(await _getListTimekeepingOffsetRequest(fromDate, toDate));
        listRequestAll.addAll(await _getListOnLeaveRequest(fromDate, toDate));
        listRequestAll.addAll(await _getListAdvanceRequest());
        for (var request in listRequestAll) {
          if (request.decision == 0) {
            listRequestNew.add(request);
          } else if (request.decision == 3) {
            listRequestApprove.add(request);
          } else if (request.decision == 4) {
            listRequestReject.add(request);
          }
        }
        emit(state.copyWith(
            listRequestNew: listRequestNew,
            listRequestApprove: listRequestApprove,
            listRequestReject: listRequestReject,
            status: RequestManagementStatus.success));
      }
    });
    on<ChooseDateRangeEvent>((event, emit) async {
      emit(state.copyWith(status: RequestManagementStatus.loading));
      List<dynamic> listRequestAll = [];
      List<dynamic> listRequestNew = [];
      List<dynamic> listRequestApprove = [];
      List<dynamic> listRequestReject = [];
      listRequestAll.addAll(
          await _getListTimekeepingOffsetRequest(event.fromDate, event.toDate));
      listRequestAll
          .addAll(await _getListOnLeaveRequest(event.fromDate, event.toDate));
      listRequestAll.addAll(await _getListAdvanceRequest());
      for (var request in listRequestAll) {
        if (request.decision == 0) {
          listRequestNew.add(request);
        } else if (request.decision == 3) {
          listRequestApprove.add(request);
        } else if (request.decision == 4) {
          listRequestReject.add(request);
        }
      }
      emit(state.copyWith(
          fromDate: event.fromDate,
          toDate: event.toDate,
          listRequestNew: listRequestNew,
          listRequestApprove: listRequestApprove,
          listRequestReject: listRequestReject,
          status: RequestManagementStatus.success));
    });
    on<RequestManagementDeleteEvent>((event, emit) async {
      String? res;
      if (event.model is TimekeepingOffsetRequestModel) {
        res =
            await ApiProvider().deleteTimekeepingOffsetRequest(event.model.id);
      } else if (event.model is OnLeaveRequestModel) {
        res = await ApiProvider().deleteOnLeaveRequest(event.model.id);
      }
      if (res == 'OK') {
        EasyLoading.showSuccess('Delete success');
      } else {
        EasyLoading.showError('Something is wrong');
      }
    });
    on<GiveDecisionDocType>((event, emit) async {
      String res;
      res = await ApiProvider()
          .giveDecisionDocType(event.docID, event.docType, event.status);
      if (res == 'OK') {
        EasyLoading.showSuccess('Save success');
      } else {
        EasyLoading.showError('Something is wrong');
      }
    });
  }
}

Future<List<TimekeepingOffsetRequestModel>> _getListTimekeepingOffsetRequest(
    DateTime fromDate, DateTime toDate) async {
  List<TimekeepingOffsetRequestModel> list =
      await ApiProvider().getListTimekeepingOffsetRequest(fromDate, toDate);
  return list;
}

Future<List<OnLeaveRequestModel>> _getListOnLeaveRequest(
    DateTime fromDate, DateTime toDate) async {
  List<OnLeaveRequestModel> list =
      await ApiProvider().getListOnLeaveRequest(fromDate, toDate);
  return list;
}

Future<List<AdvanceRequestModel>> _getListAdvanceRequest() async {
  List<AdvanceRequestModel> list =
      await ApiProvider().getListAdvanceRequest(UserModel.id);
  return list;
}
