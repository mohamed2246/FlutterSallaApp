import 'package:abd_allah_shop_app/ShopApp/Login/Cubit/states.dart';
import 'package:abd_allah_shop_app/ShopApp/Network/dioHelper.dart';
import 'package:abd_allah_shop_app/ShopApp/Shared/Component.dart';
import 'package:abd_allah_shop_app/modules/home_model.dart';
import 'package:abd_allah_shop_app/modules/login_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Network/End_Points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginIntialStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.remove_red_eye_rounded;
  bool isPassword = true;
  ShopLoginModel? LoginModel;

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingStates());
    dioHelper.postData(
         url: LOGIN,
      data: {"email": email, "password": password},

    ).then((value) {
      LoginModel = ShopLoginModel.fromJosn(value.data);
      print(LoginModel?.data?.name);
      print(LoginModel?.data?.email);

      emit(ShopLoginSuccessStates(LoginModel));

    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorStates(error.toString()));
    });
  }
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined :Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityStates());
  }

}
