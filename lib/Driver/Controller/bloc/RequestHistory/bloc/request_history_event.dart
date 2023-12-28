part of 'request_history_bloc.dart';

@immutable
sealed class RequestHistoryEvent {}

class LoadRequestHistory extends RequestHistoryEvent{
  int page_number;
  LoadRequestHistory(this.page_number);

}
class LoadMoreRequestHistory extends RequestHistoryEvent{
  int page_number;
  LoadMoreRequestHistory(this.page_number);

}
class GetRequestHistory extends RequestHistoryEvent{
  
}