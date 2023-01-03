import 'package:abd_allah_shop_app/ShopApp/Network/End_Points.dart';
import 'package:abd_allah_shop_app/ShopApp/Network/dioHelper.dart';
import 'package:abd_allah_shop_app/ShopApp/Search/states.dart';
import 'package:abd_allah_shop_app/ShopApp/Shared/Component.dart';
import 'package:abd_allah_shop_app/modules/search_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialState());
  SearchModel? model ;
  static SearchCubit get(context) => BlocProvider.of(context);
  void search(String text){
    emit(SearchLoadingState());
    dioHelper.postData(url: SEARCH, token: token, data: {
      'text' :text
    }).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState(error));
    });
  }

}