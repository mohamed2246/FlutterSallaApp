

import '../modules/login_model.dart';

abstract class ShopRegiterStates {}
class ShopRegiterIntialStates extends ShopRegiterStates{}


class ShopRegiterLoadingStates extends ShopRegiterStates{}

class ShopRegiterSuccessStates extends ShopRegiterStates{

  ShopLoginModel? RegiterModel;


  ShopRegiterSuccessStates(this.RegiterModel);
}

class ShopRegiterErrorStates extends ShopRegiterStates {
  late final String Error ;
  ShopRegiterErrorStates(this.Error);
}

class ShopRegisterChangePasswordVisibilityStates extends ShopRegiterStates{}



