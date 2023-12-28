part of 'request_history_bloc.dart';

@immutable
sealed class RequestHistoryState {}

final class RequestHistoryInitial extends RequestHistoryState {}

final class RequestHistoryLoading extends RequestHistoryState {}

final class RequestHistoryLoaded extends RequestHistoryState {
  RequestModel? data;
  RequestHistoryLoaded(this.data);
}