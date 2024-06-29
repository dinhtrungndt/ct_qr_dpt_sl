part of 'position_bloc.dart';

abstract class PositionState extends Equatable {
  const PositionState();

  @override
  List<Object> get props => [];
}

class PositionInitial extends PositionState {}

class PositionWaiting extends PositionState {}

class PositionSuccess extends PositionState {
  final List<PositionModel> positionList;
  const PositionSuccess({required this.positionList});
}
