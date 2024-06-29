import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/method/hrm_method.dart';
import 'package:erp/model/hrm_model/employee_model.dart';
import 'package:erp/model/hrm_model/shift_model.dart';
import 'package:erp/model/hrm_model/work_plan_model.dart';
import 'package:erp/model/login_model.dart';
import 'package:erp/network/api_provider.dart';

part 'shift_assignment_event.dart';
part 'shift_assignment_state.dart';

class ShiftAssignmentBloc
    extends Bloc<ShiftAssignmentEvent, ShiftAssignmentState> {
  ShiftAssignmentBloc() : super(ShiftAssignmentInitial()) {
    on<ShiftAssignmentInitialEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      DateTime now = DateTime.now();
      DateTime fromDate = now.subtract(Duration(days: now.weekday - 1));
      DateTime toDate =
          now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
      List<ShiftModel> listShiftModel = await ApiProvider().getListShiftModel();
      var body = {
        "from": fromDate.toIso8601String(),
        "to": toDate.toIso8601String(),
      };
      List<WorkPlanModel> listWorkPlanModel =
          await ApiProvider().getWorkPlanWithDate(body);
      emit(ShiftAssignmentState(
          listWorkPlanModel: listWorkPlanModel,
          listShiftModel: listShiftModel,
          day: now,
          first: fromDate,
          last: toDate,
          status: Status.initial));
    });

    on<ChangeWeekEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      DateTime result =
          (state.day as DateTime).subtract(Duration(days: event.number * 7));
      DateTime fromDate = result.subtract(Duration(days: result.weekday - 1));
      DateTime toDate =
          result.add(Duration(days: DateTime.daysPerWeek - result.weekday));
      var body = {
        "from": fromDate.toIso8601String(),
        "to": toDate.toIso8601String(),
      };
      List<WorkPlanModel> listWorkPlanModel =
          await ApiProvider().getWorkPlanWithDate(body);
      emit(state.copyWith(
          listWorkPlanModel: listWorkPlanModel,
          day: result,
          first: fromDate,
          last: toDate,
          status: Status.initial));
    });

    on<ChooseShiftAssignmentEvent>((event, emit) {
      emit(state.copyWith(shiftModel: event.shiftModel));
    });
    on<ChooseEmployeeEvent>((event, emit) {
      emit(state.copyWith(employeeID: event.employeeID));
    });
    on<AddWorkPlanEvent>((event, emit) async {
      if (state.employeeID == null || state.shiftModel == null) {
        emit(state.copyWith(status: Status.lack));
      } else {
        DateTime date = event.dateApply;
        String dStr = date.day < 10 ? '0${date.day}' : date.day.toString();
        String mStr =
            date.month < 10 ? '0${date.month}' : date.month.toString();
        var data = {
          'employeeID': state.employeeID,
          'c$mStr$dStr': state.shiftModel?.id,
          'shift': state.shiftModel?.id,
          'createdBy': User.no_,
          'updatedBy': User.no_,
          'siteID': User.site,
          'yearly': date.year
        };
        String result = await ApiProvider().addWorkPlan(data);
        if (result == 'ADD' || result == 'UPDATE') {
          var body = {
            "from": state.first?.toIso8601String(),
            "to": state.last?.toIso8601String(),
          };
          List<WorkPlanModel> listWorkPlanModel =
              await ApiProvider().getWorkPlanWithDate(body);
          emit(state.copyWith(
              status: Status.saveSuccess,
              listWorkPlanModel: listWorkPlanModel));
        } else {
          emit(state.copyWith(status: Status.failure));
        }
      }
    });
    on<DeleteWorkPlanEvent>((event, emit) async {
      emit(state.copyWith(status: Status.initial));
      String result =
          await ApiProvider().deleteWorkPlan(event.dateApply, event.shiftID);
      if (result == 'OK') {
        state.listWorkPlanModel.removeWhere((element) =>
            element.shiftID == event.shiftID &&
            element.day.year == event.dateApply.year &&
            element.day.month == event.dateApply.month &&
            element.day.day == event.dateApply.day);
        emit(state.copyWith(status: Status.deleteSuccess));
      } else {
        emit(state.copyWith(status: Status.failure));
      }
    });
  }
}
