import 'package:abd_allah_shop_app/ShopApp/Login/shopLoginScreen.dart';
import 'package:abd_allah_shop_app/ShopApp/Network/Local/CachHelper.dart';
import 'package:abd_allah_shop_app/ShopApp/Search/searsh_screen.dart';
import 'package:abd_allah_shop_app/ShopApp/Shared/Component.dart';
import 'package:abd_allah_shop_app/ShopApp/shopCubit/ShopCubit.dart';
import 'package:abd_allah_shop_app/ShopApp/shopCubit/shopStates.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=> shopCubit()..getHomeData()..getCatigoryData()..getFavoriteData()..getUserData(),
      child: BlocConsumer<shopCubit, shopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = shopCubit.get(context);
            /*return ConditionalBuilder(
              condition: shopCubit.get(context).homeModel != null &&
                  shopCubit.get(context).catigoriesModel != null &&
                  shopCubit.get(context).favorietsModel != null,
               fallback: (context)=> Center(child: CircularProgressIndicator()),

               builder: (context)=>*/

                 return  Scaffold(
                     appBar: AppBar(title: Text('Salla'), actions: [
                       IconButton(
                           icon: Icon(
                             Icons.search,
                           ),
                           onPressed: () {
                             NavigateTo(context, SearchScreen());
                           }),
                     ]),
                     body: cubit.bottomScreen[cubit.currentIndex],
                     bottomNavigationBar: BottomNavigationBar(
                       currentIndex: shopCubit.get(context).currentIndex,
                       items: cubit.botttomNavBarItems,
                       onTap: (index) {
                         cubit.changeBottom(index);
                       },
                     ),
                   );

          }),
    );
  }
}
