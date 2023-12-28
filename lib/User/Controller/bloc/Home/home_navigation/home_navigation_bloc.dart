import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'home_navigation_event.dart';
part 'home_navigation_state.dart';

class HomeNavigationBloc extends Bloc<HomeNavigationEvent, HomeNavigationState> {
  HomeNavigationBloc() : super(HomeNavigationInitial()) {
    on<HomeNavigationEvent>((event, emit) {
      // TODO: implement event handler
    });
      on<onHomeIndexChanged>((event, emit) {
      if (event.index == 0) {
        print("First Page");
        emit(FirstPageState());
      }
      if (event.index == 1) {
        print("Second Page");
        emit(SecondPageState());
      }
      if (event.index == 2) {
        print("Third Page");
        emit(ThirdPageState());
      }
      if (event.index == 3) {
        print("Fourth Page");
        emit(FourthPageState());
      }
    });
  }
}
