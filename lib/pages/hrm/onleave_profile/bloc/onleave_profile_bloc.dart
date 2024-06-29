import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/hrm_model/on_leave_model.dart';
import 'package:erp/network/api_provider.dart';

part 'onleave_profile_event.dart';
part 'onleave_profile_state.dart';

class OnleaveProfileBloc
    extends Bloc<OnleaveProfileEvent, OnleaveProfileState> {
  OnleaveProfileBloc() : super(OnleaveProfileInitial()) {
    on<OnleaveProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetOnLeaveProfileEvent>((event, emit) async {
      OnLeaveProfileModel listOnLeaveKindModel =
          await ApiProvider().getOnLeaveProfile();
      emit(OnleaveProfileSuccess(listOnLeaveKindModel));
    });
  }
}
