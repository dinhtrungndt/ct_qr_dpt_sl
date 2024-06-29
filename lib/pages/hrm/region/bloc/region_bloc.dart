import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../model/hrm_model/company_model.dart';
import '../../../../network/api_provider.dart';

part 'region_event.dart';
part 'region_state.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  RegionBloc() : super(RegionInitial()) {
    on<GetRegionEvent>((event, emit) async {
      emit(RegionWaiting());
      List<RegionModel> regionList = await ApiProvider().getRegion();
      emit(RegionSuccess(regionList: regionList));
    });
    on<AddRegionEvent>((event, emit) async {
      emit(RegionWaiting());
      String result = await ApiProvider()
          .postAddRegion(event.id, event.name, event.description);
      EasyLoading.showSuccess("Save success");
      emit(RegionAddSuccess(message: result));
    });
    on<DeleteRegionEvent>((event, emit) async {
      String result = await ApiProvider().deleteRegion(event.id);
      if (result == 'OK') {
        return EasyLoading.showSuccess("Delete success");
      } else {
        return EasyLoading.showError("Something is wrong !");
      }
    });
  }
}
