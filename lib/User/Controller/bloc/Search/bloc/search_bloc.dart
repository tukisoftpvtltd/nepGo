import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Functions/capitalize.dart';
import '../../../repositories/search/search_repository.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {
    });
    on<SearchLoading>((event, emit) async {
      emit(SearchLoadingState());
      List searchData = await SearchForTheKey(event.index, 
      capitalize(event.searchKey),
      event.BestMatch,
      event.New,
      event.openPlace,
      event.name,
      event.distance,
      event.sales);
      emit(SearchLoadedState(searchData));

    });
   
  }
}


  Future<List> SearchForTheKey(int TabIndex ,
  String Key,
  bool bestMatch,
    bool isNew,
    String isOpen,
    String name,
    String Distance,
    String Sales) async {
      List data=[];
    if (TabIndex == 0) {
      data = await  searchRestaurant(Key,bestMatch,isNew,isOpen,name,Distance,Sales);
    }
    if (TabIndex == 1) {
      data = await  searchGrocery(Key,bestMatch,isNew,isOpen,name,Distance,Sales);
    }
    return data;
  }
List RestroList =[];
List GroceryList =[];
bool loading = false;
String key='';

  Future<List> searchRestaurant(
    String searchKey,
    bool bestMatch,
    bool isNew,
    String isOpen,
    String name,
    String Distance,
    String Sales
    ) async {
      RestroList = [];
      loading = true;
      key = searchKey;
      print("The filter data are");
      print(name);
      print(Distance);
      print(Sales);
    SharedPreferences _locationDetail = await SharedPreferences.getInstance();
    String? latitude = _locationDetail.getString('latitude');
    String? longitude = _locationDetail.getString('longitude');
    print("the latitude is");
    print(latitude);
    print("The longitude is");
    print(longitude);
    SearchPageRepository repo = SearchPageRepository();
    SearchResponse? response;
    if (bestMatch == true
    && name == "null" &&
        Distance == 'null' &&
        Sales == "null"
    ) {
      response =
          await repo.getSearchData(searchKey, "1", latitude!, longitude!,isOpen);
      print("1");
    } else if (isNew == true
    && name == "null" &&
        Distance == 'null' &&
        Sales == "null") {
      response = await repo.getSearchDataOrderByNewlyCreated(
          searchKey, "1", latitude!, longitude!,isOpen);
      print("2");
    } else if (isNew == false &&
        name == "null" &&
        Distance == 'null' &&
        Sales == "null") {
      response =
          await repo.getSearchData(searchKey, "1", latitude!, longitude!,isOpen);
      print("3");
    } else if (name == "ASC" &&
        Distance == "null" &&
        Sales == "null") {
      response = await repo.getSearchDataOrderByNameASC(
          searchKey, "1", latitude!, longitude!,isOpen);
      print("4");
    } else if (name == "DESC" &&
        Distance == "null" &&
        Sales == "null") {
      response = await repo.getSearchDataOrderByNameDESC(
          searchKey, "1", latitude!, longitude!,isOpen);
      print("5");
    } else if (name == "null" &&
        Distance == 'ASC' &&
        Sales == "null") {
      response = await repo.getSearchDataOrderByDistance(
          searchKey, "1", latitude!, longitude!,isOpen);
      print("6");
    } else if (name == "null" &&
        Distance == 'null' &&
        Sales == "ASC") {
      response =
          await repo.getSearchData(searchKey, "1", latitude!, longitude!,isOpen);
      print("1");
    }
    var data = jsonDecode(response!.body);
    List restro = data['serviceProvider'];
    List itemList = data['itemsWithServieProviders'];
    int restroLength = restro.length;
    if (searchKey == '') {
      key = "null";
    } else {
      key = capitalize(searchKey);
    }
    for (int k = 0; k < itemList.length; k++) {
      for (int i = 0; i < restroLength; i++) {
        if (capitalize(restro[i]['fullname']).contains(key) &&
            capitalize(itemList[k]['fullname']).contains(key)) {
          restro.removeAt(i);
        }
      }
    }
    RestroList.clear();
    RestroList.addAll(restro);
    RestroList.addAll(itemList);
    print("The restro list is");
    return RestroList;
    
  }



  Future<List> searchGrocery(String searchKey,
  bool bestMatch,
    bool isNew,
    String isOpen,
    String name,
    String Distance,
    String Sales) async {
    
      GroceryList = [];
      loading = true;
      key = searchKey;
   
    SharedPreferences _locationDetail = await SharedPreferences.getInstance();
    String? latitude = _locationDetail.getString('latitude');
    String? longitude = _locationDetail.getString('longitude');
    SearchPageRepository repo = SearchPageRepository();
    SearchResponse? response;
    if (bestMatch == true
     && name == "null" &&
        Distance == 'null' &&
        Sales == "null"
    ) {
      response =
          await repo.getSearchData(searchKey, "2", latitude!, longitude!,isOpen);
      print("1");
    } else if (isNew == true
     && name == "null" &&
        Distance == 'null' &&
        Sales == "null"
    ) {
      response = await repo.getSearchDataOrderByNewlyCreated(
          searchKey, "2", latitude!, longitude!,isOpen);
      print("2");
    } else if (isNew == false &&
        name == "null" &&
        Distance == 'null' &&
        Sales == "null") {
      response =
          await repo.getSearchData(searchKey, "2", latitude!, longitude!,isOpen);
      print("3");
    } else if (name == "ASC" &&
        Distance == "null" &&
        Sales == "null") {
      response = await repo.getSearchDataOrderByNameASC(
          searchKey, "2", latitude!, longitude!,isOpen);
      print("4");
    } else if (name == "DESC" &&
        Distance == "null" &&
        Sales == "null") {
      response = await repo.getSearchDataOrderByNameDESC(
          searchKey, "2", latitude!, longitude!,isOpen);
      print("5");
    } else if (name == "null" &&
        Distance == 'ASC' &&
        Sales == "null") {
      response = await repo.getSearchDataOrderByDistance(
          searchKey, "2", latitude!, longitude!,isOpen);
      print("6");
    } else if (name == "null" &&
        Distance == 'null' &&
        Sales == "ASC") {
      response =
          await repo.getSearchData(searchKey, "2", latitude!, longitude!,isOpen);
      print("7");
    }
    var data = jsonDecode(response!.body);
    List grocery = data['serviceProvider'];
    List itemList = data['itemsWithServieProviders'];
    int groceryLength = grocery.length;
    if (searchKey == '') {
      key = "null";
      print("Search key is empty");
    } else {
      key = searchKey;
    }
    for (int k = 0; k < itemList.length; k++) {
      for (int i = 0; i < groceryLength; i++) {
        if (grocery[i]['fullname'].contains(key) &&
            itemList[k]['fullname'].contains(key)) {
          grocery.removeAt(i);
        }
      }
    }
    GroceryList.clear();
    GroceryList.addAll(grocery);
    GroceryList.addAll(itemList);
    print("The grocery list is");
    return GroceryList;
    
  }