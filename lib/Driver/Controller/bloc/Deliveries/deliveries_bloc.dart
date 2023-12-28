import 'package:bloc/bloc.dart';
import 'package:food_app/Driver/Controller/repository/MyDeliveriesRepo.dart';
import 'package:food_app/Driver/Model/MyDeliveriesModel.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'deliveries_event.dart';
part 'deliveries_state.dart';

class DeliveriesBloc extends Bloc<DeliveriesEvent, DeliveriesState> {
  DeliveriesBloc() : super(DeliveriesInitial()) {
    on<DeliveriesEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadDeliveries>((event, emit) async{
      emit(DeliveriesLoadingState());
      MyDeliveries repo = MyDeliveries();
      print("the did is");
      print(event.did);
      MyDeliveriesModel model = await  repo.GetMyDeliveries(event.did.toString());
      emit(DeliveriesLoadedState(model));
    });
    

  }
}
