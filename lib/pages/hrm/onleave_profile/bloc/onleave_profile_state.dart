part of 'onleave_profile_bloc.dart';

abstract class OnleaveProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class OnleaveProfileInitial extends OnleaveProfileState {}

class OnleaveProfileSuccess extends OnleaveProfileState {
  final OnLeaveProfileModel onleaveProfile;
  OnleaveProfileSuccess(this.onleaveProfile);
}
