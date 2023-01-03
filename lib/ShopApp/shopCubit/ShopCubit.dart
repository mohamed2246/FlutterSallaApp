import 'package:abd_allah_shop_app/ShopApp/Network/dioHelper.dart';
import 'package:abd_allah_shop_app/ShopApp/Products/products_screen.dart';
import 'package:abd_allah_shop_app/ShopApp/favorite/favorite_screen.dart';
import 'package:abd_allah_shop_app/ShopApp/shopCubit/shopStates.dart';
import 'package:abd_allah_shop_app/modules/catigories_model.dart';
import 'package:abd_allah_shop_app/modules/favoriets_model.dart';
import 'package:abd_allah_shop_app/modules/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/change_favorite_model.dart';
import '../../modules/home_model.dart';
import '../Catigories/catigories_screen.dart';
import '../Network/End_Points.dart';
import '../Network/Local/CachHelper.dart';
import '../Settings/settings_screen.dart';
import '../Shared/Component.dart';

class shopCubit extends Cubit<shopStates> {
  shopCubit() : super(ShopIntialStates());

  static shopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  Map<int?, bool?> isFiv = {};

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CatigoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> botttomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Catigories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomStates());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    dioHelper.getData(url: Home, token: CachHelper.getData(key: 'token')).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel);
      emit(ShopSuccessHomeDataState());

      homeModel!.data!.products!.forEach((element) {
        isFiv.addAll({element.id: element.inFavorites});
      });

      print(isFiv.toString());
    }).catchError((error) {
      emit(ShopErrorHomeDataState(error.toString()));
      print(error.toString());
    });
  }

  CatigoriesModel? catigoriesModel;

  void getCatigoryData() {
    emit(ShopLoadingCatigiriesDataState());

    dioHelper.getData(url: GET_CATIGORIES, token: CachHelper.getData(key: 'token')).then((value) {
      catigoriesModel = CatigoriesModel.fromJosn(value.data);
      print(catigoriesModel);
      emit(ShopSuccessCatigiriesDataState());
    }).catchError((error) {
      emit(ShopErrorCatigiriesDataState(error.toString()));
      print(error.toString());
    });
  }

  ChangeFavModel? changeFavModel ;

  void ChangeFavoriets(int productId) {
    isFiv[productId] = !isFiv[productId]!;
    emit(ShopChangeFavorietsDataState(changeFavModel));
    dioHelper
        .postData(
      url: FAVORIETS,
      data: {'product_id': productId},
      token: CachHelper.getData(key: 'token'),
    )
        .then((value) {
      changeFavModel = ChangeFavModel.fromJson(value.data);

      if(!changeFavModel!.status!){
        isFiv[productId] = !isFiv[productId]!;
      }else{
        getFavoriteData();
      }
      print(value.data);

      emit(ShopSuccessChangeFavorietsDataState());

    }).catchError((error) {
      isFiv[productId] = !isFiv[productId]!;
      emit(ShopErrorChangeFavorietsDataState(error));
    });
  }


  FavouritesModel? favorietsModel;

  void getFavoriteData() {
    emit(ShopLoadingGetFavorietsDataState());
    dioHelper.getData(url: FAVORIETS, token: CachHelper.getData(key: 'token')).then((value) {
      favorietsModel = FavouritesModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(ShopSuccessGetFavorietsDataState());
    }).catchError((error) {
      emit(ShopErrorGetFavorietsDataState(error.toString()));
      print(error.toString());
    });
  }


  ShopLoginModel? userModel;

  void getUserData(){
    emit(ShopLoadingGetUserDataState());
    dioHelper.getData(url: PROFILE, token: CachHelper.getData(key: 'token')).then((value) {
      userModel = ShopLoginModel.fromJosn(value.data);
      printFullText(userModel!.data!.name.toString());
      emit(ShopSuccessGetUserDataState(userModel));
    }).catchError((error) {
      emit(ShopErrorGetUserDataState(error.toString()));
      print(error.toString());
    });
  }

  void updateUserData({
  required String name ,
    required String email ,
    required String phone ,

}){
    emit(ShopLoadingUpdateUserDataState());
    dioHelper.putData(url: UPDATE_PROFILE, token: CachHelper.getData(key: 'token') , data:{'name':name , 'email' :email , 'phone' :phone} ).then((value) {
      userModel = ShopLoginModel.fromJosn(value.data);
      printFullText(userModel!.data!.name.toString());
      emit(ShopSuccessUpdateUserDataState(userModel));
    }).catchError((error) {
      emit(ShopErrorUpdateUserDataState(error.toString()));
      print(error.toString());
    });
  }

}
