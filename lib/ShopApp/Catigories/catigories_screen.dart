import 'package:abd_allah_shop_app/ShopApp/shopCubit/shopStates.dart';
import 'package:abd_allah_shop_app/modules/catigories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Shared/Component.dart';
import '../shopCubit/ShopCubit.dart';

class CatigoriesScreen extends StatelessWidget {
  const CatigoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit, shopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return buildCatItem(shopCubit.get(context).catigoriesModel!.data!.data![index]);
            },
            separatorBuilder: (context, index) {
              return dividerWidget();
            },
            itemCount: shopCubit.get(context).catigoriesModel!.data!.data!.length,
        );
      },

    );
  }

  Widget buildCatItem( DataModel model) {
    return
       Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                  model.image.toString()),
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              model.name.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
  }
}
