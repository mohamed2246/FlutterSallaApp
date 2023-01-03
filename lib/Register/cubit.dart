

import 'package:abd_allah_shop_app/Register/states.dart';
import 'package:abd_allah_shop_app/ShopApp/Network/dioHelper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ShopApp/Network/End_Points.dart';
import '../modules/login_model.dart';

class ShopRegisterCubit extends Cubit<ShopRegiterStates> {
  ShopRegisterCubit() : super(ShopRegiterIntialStates());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.remove_red_eye_rounded;
  bool isPassword = true;
  ShopLoginModel? RegisterModel;

  void userRegister({required String email, required String password ,required String name , required String phone}) {
    emit(ShopRegiterLoadingStates());
    dioHelper.postData(
         url: Register,
      data: {"email": email, "password": password , "name":name , 'phone':phone },

    ).then((value) {
      RegisterModel = ShopLoginModel.fromJosn(value.data);
      print(RegisterModel?.data?.name);
      print(RegisterModel?.data?.email);

      emit(ShopRegiterSuccessStates(RegisterModel));

    }).catchError((error){
      print(error.toString());
      emit(ShopRegiterErrorStates(error.toString()));
    });
  }
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined :Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityStates());
  }

}
