import 'package:bloc/bloc.dart';
import 'package:food_app/Driver/Controller/repository/Sales/requestHistory/requestModel.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repository/Sales/requestHistory/requestRepository.dart';


part 'request_history_event.dart';
part 'request_history_state.dart';

class RequestHistoryBloc extends Bloc<RequestHistoryEvent, RequestHistoryState> {
  RequestHistoryBloc() : super(RequestHistoryInitial()) {
    on<RequestHistoryEvent>((event, emit) {
      // TODO: implement event handler
    });
      on<LoadRequestHistory>((event, emit) async{
      emit(RequestHistoryLoading());
      SharedPreferences prefs = await SharedPreferences.getInstance();
    String? driverId = prefs.getString('driverId');
    print("the driver id is"+driverId.toString());
    RequestRepository repo = new RequestRepository();
    RequestModel? requestModel = await repo.getrequestData(driverId!,event.page_number);
    print(requestModel!.data?.length);
      emit(RequestHistoryLoaded(requestModel));
    
    });
     on<LoadMoreRequestHistory>((event, emit) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
    String? driverId = prefs.getString('driverId');
    print("the driver id is"+driverId.toString());
    RequestRepository repo = new RequestRepository();
     RequestModel? requestModel = await repo.getrequestData(driverId!,event.page_number);
      emit(RequestHistoryLoaded(requestModel));
    
    });
  }
}
