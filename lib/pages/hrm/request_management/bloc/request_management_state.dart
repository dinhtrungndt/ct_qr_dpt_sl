part of 'request_management_bloc.dart';

enum RequestManagementStatus { success, loading }

class RequestManagementState extends Equatable {
  final DateTime? fromDate;
  final DateTime? toDate;
  final List<dynamic> listRequestNew;
  final List<dynamic> listRequestApprove;
  final List<dynamic> listRequestReject;
  final RequestManagementStatus status;

  const RequestManagementState(
      {this.fromDate,
      this.toDate,
      this.listRequestNew = const [],
      this.listRequestApprove = const [],
      this.listRequestReject = const [],
      this.status = RequestManagementStatus.loading});
  RequestManagementState copyWith(
      {DateTime? fromDate,
      DateTime? toDate,
      List<dynamic>? listRequestNew,
      List<dynamic>? listRequestApprove,
      List<dynamic>? listRequestReject,
      RequestManagementStatus? status}) {
    return RequestManagementState(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      listRequestNew: listRequestNew ?? this.listRequestNew,
      listRequestApprove: listRequestApprove ?? this.listRequestApprove,
      listRequestReject: listRequestReject ?? this.listRequestReject,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        fromDate,
        toDate,
        listRequestNew,
        listRequestApprove,
        listRequestReject,
        status
      ];
}

// class RequestManagementInitial extends RequestManagementState {}

// class RequestManagementLoading extends RequestManagementState {}

// class RequestManagementLoaded extends RequestManagementState {
//   final List<dynamic> listRequestNew;
//   final List<dynamic> listRequestApprove;
//   final List<dynamic> listRequestReject;

//   const RequestManagementLoaded({
//     this.listRequestNew = const [],
//     this.listRequestApprove = const [],
//     this.listRequestReject = const [],
//   });
// }
