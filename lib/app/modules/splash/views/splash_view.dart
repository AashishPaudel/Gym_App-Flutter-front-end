import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';
import 'splash_container.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: controller.obx(
              (_) {
            return Container();
          },
          onLoading: const SplashContainer(),
        ),
      ),
    );
  }
}
