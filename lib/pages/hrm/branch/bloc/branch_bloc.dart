import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../model/hrm_model/company_model.dart';
import '../../../../network/api_provider.dart';

part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  BranchBloc() : super(BranchInitial()) {
    on<GetBranchEvent>((event, emit) async {
      emit(BranchWaiting());
      List<BranchModel> branchList = await ApiProvider().getBranch();
      emit(BranchSuccess(branchList: branchList));
    });
    on<AddBranchEvent>((event, emit) async {
      String result = await ApiProvider().postAddBranch(
          event.id ?? null!, event.areaID, event.name, event.description);
      if (result == 'OK') EasyLoading.showSuccess('Save success');
      emit(BranchAddSuccess(message: result));
    });
    on<DeleteBranchEvent>((event, emit) async {
      String result = await ApiProvider().deleteBranch(event.id);
      emit(BranchAddSuccess(message: result));
    });
  }
}
