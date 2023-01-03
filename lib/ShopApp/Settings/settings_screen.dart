import 'package:abd_allah_shop_app/ShopApp/shopCubit/ShopCubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Shared/Component.dart';
import '../shopCubit/shopStates.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = shopCubit.get(context).userModel;
    var formKey =GlobalKey<FormState>();

    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();

    String? name = 'name';
    String? email = 'Email Address';
    String? phone = 'phone';

    nameController.text = model!.data!.name!;
    emailController.text = model!.data!.email!;
    phoneController.text = model!.data!.phone!;

    return BlocConsumer<shopCubit, shopStates>(
      listener: (context, state) {
        /*if(state is ShopSuccessGetUserDataState ){
          nameController.text= state.userModel!.data!.name!;
          emailController.text= state.userModel!.data!.email!;
          phoneController.text= state.userModel!.data!.phone!;
        }*/
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: shopCubit.get(context).userModel != null,
          builder: (contetxt) {
            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if(state is ShopLoadingUpdateUserDataState) LinearProgressIndicator(),
                        SizedBox(height: 20,),
                        defaultFormText(
                          control: nameController,
                          type: TextInputType.text,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Name must not be empty';
                            }
                            return null;
                          },
                          label: name,
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormText(
                          control: emailController,
                          type: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Email must not be empty';
                            }
                            return null;
                          },
                          label: email,
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormText(
                          control: phoneController,
                          type: TextInputType.phone,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Phone must not be empty';
                            }
                            return null;
                          },
                          label: phone,
                          prefix: Icons.phone,
                        ),

                        SizedBox(height: 40,),
                        defaultButton(
                          radius: 5,
                          onTap: () {
                            if(formKey.currentState!.validate()){
                              shopCubit.get(context).updateUserData(name: nameController.text , email: emailController.text ,phone: phoneController.text);

                            }
                          },
                          text: 'Update',
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        defaultButton(
                          radius: 5,
                          onTap: () {
                            SignOut(context);
                          },
                          text: 'Logout',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
