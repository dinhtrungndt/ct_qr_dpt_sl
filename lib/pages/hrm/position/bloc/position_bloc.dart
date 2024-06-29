import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/hrm_model/company_model.dart';
import 'package:erp/network/api_provider.dart';

part 'position_event.dart';
part 'position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  PositionBloc() : super(PositionInitial()) {
    on<PositionEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetPositionEvent>((event, emit) async {
      // TODO: implement event handler
      emit(PositionWaiting());
      List<PositionModel> positionList = await ApiProvider().getPosition();
      emit(PositionSuccess(positionList: positionList));
    });
  }
}
