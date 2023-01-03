import 'package:abd_allah_shop_app/ShopApp/Login/Cubit/cubit.dart';
import 'package:abd_allah_shop_app/ShopApp/shopCubit/ShopCubit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/favoriets_model.dart';
import '../Login/shopLoginScreen.dart';
import '../Network/Local/CachHelper.dart';

void NavigateAndFinsh(  context  , Layout ){
  Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => Layout));
}

void NavigateAndDeleteAllRouts(context){
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      ShopLoginScreen()), (Route<dynamic> route) => false);

}

void NavigateTo(  context  , Layout ){
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => Layout));
}

void showToast({required String? text ,required ToastStates state}){
   Fluttertoast.showToast(
      msg: text.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastStates {SUCCESS , ERROR , WORNNING}

Color chooseColor(ToastStates state){
  Color color ;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WORNNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void SignOut(context){

  CachHelper.removaData(key: 'token').then((value) {
    if (value) {
      Navigator.pop(context);
      NavigateAndDeleteAllRouts(context,);
      token = null;
      print('token from signout ${CachHelper.getData(key: 'token').toString()}');
    }
  });

}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) {
    print(element.group(0));
  });
}

String? token ;

Widget dividerWidget()=>Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey,
);


Widget defaultFormText({
  required TextEditingController control,
  required TextInputType type,
  required dynamic validator,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  bool isPassword = false,
  required String? label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixClicked,
}) => TextFormField(
  controller: control,
  keyboardType: type,
  validator: validator,
  onFieldSubmitted: (s) {
        onSubmit!(s);
  },
  onTap: () {
    onTap!();
  },
  obscureText: isPassword,
  onChanged: (value) {
    onChanged!(value);
  },
  decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(
        onPressed: () {
          suffixClicked!();
        },
        icon: Icon(suffix),
      )
          : null,
      border: OutlineInputBorder()),
);


Widget defaultButton({
  double width = double.infinity,
  Color backGroundColor = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required void Function() onTap,
  required String text,
}) => Container(
    width: width,
    height: 50,
    decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(radius)),
    child: MaterialButton(
      onPressed: onTap,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ));



Widget buildFivItem( data, context , {bool isOldPrice= true}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                height: 120,
                width: 120,
                image: NetworkImage(
                  data!.image.toString(),
                ),
              ),
              if (data.discount != 0 && isOldPrice)
                Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'DISCOUND',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      data.price.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (data.discount != 0 && isOldPrice)
                      Text(
                        data.oldPrice.toString(),
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        shopCubit
                            .get(context)
                            .ChangeFavoriets(data.id!);
                        print(data.id.toString());
                      },
                      icon: CircleAvatar(
                        backgroundColor:
                        shopCubit.get(context).isFiv[data.id]!
                            ? Colors.blue
                            : Colors.grey,
                        radius: 15,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
