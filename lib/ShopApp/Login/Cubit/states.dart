import 'package:abd_allah_shop_app/modules/login_model.dart';

abstract class ShopLoginStates {}
class ShopLoginIntialStates extends ShopLoginStates{}


class ShopLoginLoadingStates extends ShopLoginStates{}

class ShopLoginSuccessStates extends ShopLoginStates{

  ShopLoginModel? loginModel;


  ShopLoginSuccessStates(this.loginModel);
}

class ShopLoginErrorStates extends ShopLoginStates {
  late final String Error ;
  ShopLoginErrorStates(this.Error);
}

class ShopChangePasswordVisibilityStates extends ShopLoginStates{}



