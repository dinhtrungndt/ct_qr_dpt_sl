part of 'branch_bloc.dart';

abstract class BranchEvent extends Equatable {
  const BranchEvent();
  @override
  List<Object> get props => [];
}

class BranchLoadEvent extends BranchEvent {}

class GetBranchEvent extends BranchEvent {
  final String site;
  final String token;
  const GetBranchEvent({required this.site, required this.token});
}

class AddBranchEvent extends BranchEvent {
  final int? id;
  final int areaID;
  final String site;
  final String name;
  final String description;
  const AddBranchEvent(
      {this.id,
      required this.areaID,
      required this.site,
      required this.name,
      required this.description});
}

class DeleteBranchEvent extends BranchEvent {
  final int id;
  const DeleteBranchEvent({required this.id});
}
