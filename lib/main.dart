import 'package:abd_allah_shop_app/ShopApp/Login/shopLoginScreen.dart';
import 'package:abd_allah_shop_app/ShopApp/Network/Local/CachHelper.dart';
import 'package:abd_allah_shop_app/ShopApp/Network/dioHelper.dart';
import 'package:abd_allah_shop_app/ShopApp/onBoarding/onboarding.dart';
import 'package:abd_allah_shop_app/ShopApp/shopCubit/ShopCubit.dart';
import 'package:abd_allah_shop_app/ShopApp/shopCubit/shopStates.dart';
import 'package:abd_allah_shop_app/ShopApp/shopLayout.dart';
import 'package:abd_allah_shop_app/const/colors.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'ShopApp/Login/Cubit/CubicObserver.dart';
import 'ShopApp/Shared/Component.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  dioHelper.intia();
  await CachHelper.init();
  Widget widget;
  dynamic onBoarding = CachHelper.getData(key: 'onBoarding');
   token = CachHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => shopCubit()..getHomeData()..getCatigoryData()..getFavoriteData()..getUserData(),
      child: BlocConsumer<shopCubit, shopStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          scrollBehavior: AppScrollBehavior(),
          debugShowCheckedModeBanner: false,
          home: startWidget,
          themeMode: ThemeMode.light,
          theme: ThemeData(
              dividerColor: HexColor('333739'),
              primarySwatch: MainColor,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: MainColor,
                  elevation: 20,
                  backgroundColor: Colors.white,
                  unselectedItemColor: Colors.grey)),
          darkTheme: ThemeData(
            dividerColor: HexColor('333739'),
            primarySwatch: MainColor,
            scaffoldBackgroundColor: HexColor('333739'),
            appBarTheme: AppBarTheme(
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                )),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: MainColor,
                elevation: 20,
                backgroundColor: HexColor('333739'),
                unselectedItemColor: Colors.grey),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
