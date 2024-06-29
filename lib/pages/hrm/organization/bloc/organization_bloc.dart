import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/hrm_model/company_model.dart';
import 'package:erp/network/api_provider.dart';

part 'organization_event.dart';
part 'organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  OrganizationBloc() : super(OrganizationInitial()) {
    on<OrganizationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetDepartmentEvent>((event, emit) async {
      // TODO: implement event handler
      emit(OrganizationWaiting());
      List<OrganizationModel> branchList = await ApiProvider().getDepartment();
      emit(OrganizationSuccess(organizationList: branchList));
    });
  }
}
