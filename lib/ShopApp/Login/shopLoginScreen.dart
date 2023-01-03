import 'package:abd_allah_shop_app/Register/registerScreen.dart';
import 'package:abd_allah_shop_app/ShopApp/shopLayout.dart';
import 'package:abd_allah_shop_app/const/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Network/Local/CachHelper.dart';
import '../Shared/Component.dart';
import 'Cubit/cubit.dart';
import 'Cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  dynamic onBoarding = CachHelper.getData(key:'onBoarding');


  @override
  Widget build(BuildContext context) {
    print(onBoarding);
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessStates){
           if(state.loginModel!.status!){
                print(state.loginModel?.data?.token.toString());
                print(state.loginModel?.message.toString());
                CachHelper.SaveData(key: 'token', value: state.loginModel?.data?.token).then((value) {
                  token = state.loginModel?.data?.token.toString();
                  NavigateAndFinsh(context , ShopLayout());
                });

           }else{
             print(state.loginModel?.message.toString());
             showToast(text:state.loginModel?.message.toString() , state: ToastStates.ERROR);
           }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.headline6?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return ' email must not be empty !';
                            } else {}
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: ShopLoginCubit.get(context).isPassword,

                          onFieldSubmitted: (value){
                            if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  ShopLoginCubit.get(context).changePasswordVisibility();
                                },
                                icon: Icon(
                                    ShopLoginCubit.get(context).suffix
                                )),
                            border: OutlineInputBorder(),
                          ),

                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return ' Password too short !';
                            } else {}
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                            height: 50,
                            width: double.infinity,
                            child: ConditionalBuilder(
                              builder: (context) => ElevatedButton(
                                child: const Text('Login'),
                                onPressed: () {
                                  if(formKey.currentState!.validate()){
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }



                                },
                              ),
                              fallback: (context) => CircularProgressIndicator(),
                              condition: state is! ShopLoginLoadingStates,
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account ? '),
                            TextButton(
                              onPressed: () {
                                NavigateTo(context , RegisterScreen());
                              },
                              child: Text(
                                'RIGISTER',
                                style: TextStyle(color: MainColor),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
