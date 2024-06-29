part of 'branch_bloc.dart';

abstract class BranchState extends Equatable {
  const BranchState();
  @override
  List<Object> get props => [];
}

class BranchInitial extends BranchState {}

class BranchError extends BranchState {
  final String errorMessage;
  const BranchError({required this.errorMessage});
}

class BranchWaiting extends BranchState {}

class BranchSuccess extends BranchState {
  final List<BranchModel> branchList;
  const BranchSuccess({required this.branchList});
}

class BranchAddSuccess extends BranchState {
  final String message;
  const BranchAddSuccess({required this.message});
}

class BranchDeleteSuccess extends BranchState {
  final String message;
  const BranchDeleteSuccess({required this.message});
}
