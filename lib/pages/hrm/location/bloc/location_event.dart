part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationLoadEvent extends LocationEvent {}

class GetLocationEvent extends LocationEvent {}

class DeleteLocationEvent extends LocationEvent {
  int id;
  DeleteLocationEvent({required this.id});
}

class LocationAddEVent extends LocationEvent {
  final int id;
  final int branchID;
  final String name;
  final String address;
  final String longitude;
  final String latitude;
  final double radius;
  const LocationAddEVent(
      {required this.id,
      required this.branchID,
      required this.name,
      required this.address,
      required this.longitude,
      required this.latitude,
      required this.radius});
}
