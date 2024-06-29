part of 'region_bloc.dart';

abstract class RegionEvent extends Equatable {
  const RegionEvent();
  @override
  List<Object> get props => [];
}

class RegionLoadEvent extends RegionEvent {}

class GetRegionEvent extends RegionEvent {}

class AddRegionEvent extends RegionEvent {
  final int id;
  final String name;
  final String description;
  const AddRegionEvent(
      {required this.id, required this.name, required this.description});
}

class DeleteRegionEvent extends RegionEvent {
  int id;
  DeleteRegionEvent({required this.id});
}
