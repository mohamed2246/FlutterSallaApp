import 'package:abd_allah_shop_app/Register/cubit.dart';
import 'package:abd_allah_shop_app/Register/states.dart';
import 'package:abd_allah_shop_app/ShopApp/shopLayout.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ShopApp/Network/Local/CachHelper.dart';
import '../const/colors.dart';
import '../ShopApp/Shared/Component.dart';
import '../ShopApp/Login/Cubit/cubit.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegiterStates>(
        listener: (context , state){

          if(state is ShopRegiterSuccessStates){
            if(state.RegiterModel!.status!){
              print(state.RegiterModel?.data?.token.toString());
              print(state.RegiterModel?.message.toString());
              CachHelper.SaveData(key: 'token', value: state.RegiterModel?.data?.token).then((value) {

                token = state.RegiterModel?.data?.token.toString();
                print('this is theeeeeeeeeeeeeeeeeeeeeee token ${token}');
                NavigateAndFinsh(context , ShopLayout());
              });

            }else{
              print(state.RegiterModel?.message.toString());
              showToast(text:state.RegiterModel?.message.toString() , state: ToastStates.ERROR);
            }
          }
        },
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(),
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
                          'Register',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        defaultFormText(
                          control: nameController,
                          type: TextInputType.text,
                          validator: (String? value){
                            if(value!.isEmpty){
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          label: 'User name',
                          prefix: Icons.person,

                        ),

                        SizedBox(
                          height: 20,
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
                          obscureText: ShopRegisterCubit.get(context).isPassword,

                          onFieldSubmitted: (value){
                            /*if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }*/
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  ShopRegisterCubit.get(context).changePasswordVisibility();
                                },
                                icon: Icon(
                                    ShopRegisterCubit.get(context).suffix
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

                        defaultFormText(
                          control: phoneController,
                          type: TextInputType.phone,
                          validator: (String? value){
                            if(value!.isEmpty){
                              return 'Please enter your phone';
                            }
                            return null;
                          },
                          label: 'User phone',
                          prefix: Icons.phone,

                        ),

                        SizedBox(
                          height: 30,
                        ),
                        Container(
                            height: 50,
                            width: double.infinity,
                            child: ConditionalBuilder(
                              builder: (context) => ElevatedButton(
                                child: const Text('Register'),
                                onPressed: () {
                                  if(formKey.currentState!.validate()){
                                   ShopRegisterCubit.get(context).userRegister(email: emailController.text, password: passwordController.text, name: nameController.text, phone: phoneController.text);
                                  }



                                },
                              ),
                              fallback: (context) => Center(child: CircularProgressIndicator()),
                              condition:state is! ShopRegiterLoadingStates,
                            )),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }


      ),
    ) ;
  }
}
