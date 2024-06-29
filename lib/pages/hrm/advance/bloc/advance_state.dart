part of 'advance_bloc.dart';

enum SendAdvanceStatus { initial, loading, success, failure }

class AdvanceState extends Equatable {
  final List<AdvanceKindModel> listAdvanceKindModel;
  final AdvanceKindModel? advanceKindModel;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int money;
  final SendAdvanceStatus sendStatus;
  final String error;
  const AdvanceState(
      {this.listAdvanceKindModel = const [],
      this.advanceKindModel,
      this.fromDate,
      this.toDate,
      this.money = 0,
      this.sendStatus = SendAdvanceStatus.initial,
      this.error = ''});

  AdvanceState copyWith(
      {List<AdvanceKindModel>? listAdvanceKindModel,
      AdvanceKindModel? advanceKindModel,
      DateTime? expirationDate,
      DateTime? fromDate,
      DateTime? toDate,
      int? money,
      SendAdvanceStatus? sendStatus,
      String? error}) {
    return AdvanceState(
        listAdvanceKindModel: listAdvanceKindModel ?? this.listAdvanceKindModel,
        advanceKindModel: advanceKindModel ?? this.advanceKindModel,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
        money: money ?? this.money,
        sendStatus: sendStatus ?? this.sendStatus,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [advanceKindModel, fromDate, toDate, sendStatus];
}
