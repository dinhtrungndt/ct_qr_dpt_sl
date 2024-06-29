part of 'request_management_bloc.dart';

abstract class RequestManagementEvent extends Equatable {
  const RequestManagementEvent();
  @override
  List<Object> get props => [];
}

class InitialRequestManagementEvent extends RequestManagementEvent {}

class RequestManagementLoadEvent extends RequestManagementEvent {}

class RequestManagementDeleteEvent extends RequestManagementEvent {
  dynamic model;
  BuildContext context;
  RequestManagementDeleteEvent({required this.model, required this.context});
}

class ChooseSalaryPeriodEvent extends RequestManagementEvent {
  final SalaryPeriodModel salaryPeriod;
  const ChooseSalaryPeriodEvent({required this.salaryPeriod});
}

class ChooseDateRangeEvent extends RequestManagementEvent {
  final DateTime fromDate;
  final DateTime toDate;
  const ChooseDateRangeEvent({required this.fromDate, required this.toDate});
}

class GiveDecisionDocType extends RequestManagementEvent {
  final int docID;
  final int status;
  final String docType;
  const GiveDecisionDocType(
      {required this.docID, required this.status, required this.docType});
}
