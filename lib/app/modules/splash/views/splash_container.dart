import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashContainer extends StatelessWidget {
  const SplashContainer({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Center(
      child: Image.asset(
        'assets/logo1.png',
        height: Get.width * 0.4,
        width: Get.width * 0.5,
        fit: BoxFit.fill,
      ),
    );
  }
}