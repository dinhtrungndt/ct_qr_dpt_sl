part of 'organization_bloc.dart';

abstract class OrganizationState extends Equatable {
  const OrganizationState();

  @override
  List<Object> get props => [];
}

class OrganizationInitial extends OrganizationState {}

class OrganizationWaiting extends OrganizationState {}

class OrganizationSuccess extends OrganizationState {
  final List<OrganizationModel> organizationList;
  const OrganizationSuccess({required this.organizationList});
}
