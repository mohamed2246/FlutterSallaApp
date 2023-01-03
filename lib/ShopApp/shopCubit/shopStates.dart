import 'package:abd_allah_shop_app/modules/login_model.dart';

import '../../modules/change_favorite_model.dart';

abstract class shopStates {}

class ShopIntialStates extends shopStates {}

class ShopChangeBottomStates extends shopStates {}

class ShopLoadingHomeDataState extends shopStates {}

class ShopSuccessHomeDataState extends shopStates {}

class ShopErrorHomeDataState extends shopStates {
  String? error;

  ShopErrorHomeDataState(this.error);
}

class ShopLoadingCatigiriesDataState extends shopStates {}

class ShopSuccessCatigiriesDataState extends shopStates {}

class ShopErrorCatigiriesDataState extends shopStates {
  String? error;

  ShopErrorCatigiriesDataState(this.error);
}

class ShopChangeFavorietsDataState extends shopStates {
  ChangeFavModel? model;

  ShopChangeFavorietsDataState(this.model);
}

class ShopSuccessChangeFavorietsDataState extends shopStates {}

class ShopErrorChangeFavorietsDataState extends shopStates {
  String? error;

  ShopErrorChangeFavorietsDataState(this.error);
}

class ShopLoadingGetFavorietsDataState extends shopStates {}
class ShopSuccessGetFavorietsDataState extends shopStates {}

class ShopErrorGetFavorietsDataState extends shopStates {
  String? error;

  ShopErrorGetFavorietsDataState(this.error);
}



class ShopLoadingGetUserDataState extends shopStates {}
class ShopSuccessGetUserDataState extends shopStates {
  ShopLoginModel? userModel;
  ShopSuccessGetUserDataState(this.userModel);
}

class ShopErrorGetUserDataState extends shopStates {
  String? error;
  ShopErrorGetUserDataState(this.error);
}




class ShopLoadingUpdateUserDataState extends shopStates {}
class ShopSuccessUpdateUserDataState extends shopStates {
  ShopLoginModel? userModel;
  ShopSuccessUpdateUserDataState(this.userModel);
}

class ShopErrorUpdateUserDataState extends shopStates {
  String? error;
  ShopErrorUpdateUserDataState(this.error);
}