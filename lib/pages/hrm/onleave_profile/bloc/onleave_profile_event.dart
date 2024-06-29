part of 'onleave_profile_bloc.dart';

abstract class OnleaveProfileEvent extends Equatable {
  const OnleaveProfileEvent();

  @override
  List<Object> get props => [];
}

class GetOnLeaveProfileEvent extends OnleaveProfileEvent {}
