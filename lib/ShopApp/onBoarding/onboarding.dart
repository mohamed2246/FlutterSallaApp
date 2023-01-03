import 'dart:ui';

import 'package:abd_allah_shop_app/ShopApp/Login/shopLoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../const/colors.dart';
import '../Network/Local/CachHelper.dart';

class BoardingModel {
  late final String image;

  late final String title;

  late final String body;

  BoardingModel(this.image, this.title, this.body);
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var controller = PageController();
  bool isLast = false;

  final List<BoardingModel> listBoardingModel = [
    BoardingModel('images/boardingImage_1.jpg', 'boarderTitle1', 'borderBody1'),
    BoardingModel('images/boardingImage_1.jpg', 'boarderTitle2', 'borderBody2'),
    BoardingModel('images/boardingImage_1.jpg', 'boarderTitle3', 'borderBody3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  onSubummit();
                },
                child: Text(
                  'SKIP',
                  style: TextStyle(color: MainColor),
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardingItem(listBoardingModel[index]),
                  itemCount: listBoardingModel.length,
                  onPageChanged: (index) {
                    if (index == listBoardingModel.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: listBoardingModel.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: MainColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 4,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: MainColor,
                    onPressed: () {
                      if (isLast == false) {
                        controller.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      } else {
                        onSubummit();
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel boardingModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image.asset(boardingModel.image)),
        Text(
          '${boardingModel.title}',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${boardingModel.body}',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void onSubummit() {
    CachHelper.SaveData( key: 'onBoarding' ,value: true,).then((value) {
      if (value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ShopLoginScreen()));
      }
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
