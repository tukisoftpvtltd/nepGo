import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
part 'internet_bloc_event.dart';
part 'internet_bloc_state.dart';


class InternetBlocBloc extends Bloc<InternetBlocEvent, InternetBlocState> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;
  InternetBlocBloc() : super(InternetInitialState()) {
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));

    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

    on<SlowInternetEvent>((event, emit) => emit(SlowInternetState()));

    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
            add(InternetGainedEvent());
            // isInternetConnected().then((connected) {
            // if(connected){
            //   add(InternetGainedEvent());
            // }});
          // if(isInternetConnected() == true){
          //    add(InternetGainedEvent());
          // }
       
        
   // Check if the internet connection is slow
        _checkForSlowInternet().then((isSlow) {
          if (isSlow) {
            // If it's a slow internet connection, emit a SlowInternetState
            add(SlowInternetEvent());
          }
        });

      } else {
        add(InternetLostEvent());
      }
    });
  }
  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
   Future<bool> isInternetConnected() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com'));
       print(response.statusCode);
      if (response.statusCode == 200) {

        return true;
      }
    } catch (e) {
      
      return false;
    }
    return false;
  }
    Future<bool> _checkForSlowInternet() async {
    const timeout = Duration(seconds: 10);
    try {
      await Future.delayed(timeout);
      final response = await http.get(Uri.parse('https://www.google.com'));
      print("the internet status code is");
       print(response.statusCode);
      if (response.statusCode != 200) {
        print("slow internet");
        print(timeout);
        return true;
      }
    } catch (e) {
      
      return true;
    }
    return false;
  }

}
