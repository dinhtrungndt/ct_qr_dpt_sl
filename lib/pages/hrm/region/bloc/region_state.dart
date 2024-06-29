part of 'region_bloc.dart';

abstract class RegionState extends Equatable {
  const RegionState();
  @override
  List<Object> get props => [];
}

class RegionInitial extends RegionState {}

class RegionError extends RegionState {
  final String errorMessage;
  const RegionError({required this.errorMessage});
}

class RegionWaiting extends RegionState {}

class RegionSuccess extends RegionState {
  final List<RegionModel> regionList;
  const RegionSuccess({required this.regionList});
}

class RegionAddSuccess extends RegionState {
  final String message;
  const RegionAddSuccess({required this.message});
}