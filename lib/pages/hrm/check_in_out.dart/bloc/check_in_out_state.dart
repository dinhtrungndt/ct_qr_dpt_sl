part of 'check_in_out_bloc.dart';

enum CheckInOutConfirmStatus {
  initialConfirm,
  loadingConfirm,
  successConfirm,
  failureConfirm
}

@immutable
class CheckInOutState extends Equatable {
  final List<ShiftModel> listShiftModel;
  final List<LocationModel> listLocationModel;
  final ShiftModel? shiftModel;
  final LocationModel? locationModel;
  final Position? currentPosition;

  final CheckInOutConfirmStatus confirmStatus;
  const CheckInOutState(
      {this.listShiftModel = const [],
      this.listLocationModel = const [],
      this.shiftModel,
      this.locationModel,
      this.currentPosition,
      this.confirmStatus = CheckInOutConfirmStatus.initialConfirm});
  CheckInOutState copyWith(
      {List<ShiftModel>? listShiftModel,
      List<LocationModel>? listLocationModel,
      ShiftModel? shiftModel,
      LocationModel? locationModel,
      Position? currentPosition,
      CheckInOutConfirmStatus? confirmStatus}) {
    return CheckInOutState(
      listShiftModel: listShiftModel ?? this.listShiftModel,
      listLocationModel: listLocationModel ?? this.listLocationModel,
      shiftModel: shiftModel ?? this.shiftModel,
      locationModel: locationModel ?? this.locationModel,
      currentPosition: currentPosition ?? this.currentPosition,
      confirmStatus: confirmStatus ?? this.confirmStatus,
    );
  }

  @override
  List<Object?> get props => [confirmStatus, shiftModel, locationModel];
}

class CheckInWaitingEvent extends CheckInOutState {}

class CheckInSuccessEvent extends CheckInOutState {}
