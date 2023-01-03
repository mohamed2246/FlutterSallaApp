import 'package:abd_allah_shop_app/modules/favoriets_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Shared/Component.dart';
import '../shopCubit/ShopCubit.dart';
import '../shopCubit/shopStates.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit, shopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:
              shopCubit.get(context).homeModel != null ,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return buildFivItem(
                  shopCubit.get(context).favorietsModel!.data!.data[index].product!,
                  context);
            },
            separatorBuilder: (context, index) {
              return dividerWidget();
            },
            itemCount: shopCubit.get(context).favorietsModel!.data!.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }


}
