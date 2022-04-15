import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gym_app/app/routes/app_pages.dart';

import '../controllers/gym_map_controller.dart';

class GymMapView extends GetView<GymMapController> {
  const GymMapView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Gym Map',
            style: Get.textTheme.headline5.copyWith(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xffE5E5E5).withOpacity(0.0),
        ),
        backgroundColor: const Color(0xffE5E5E5).withOpacity(0.5),
        body: SafeArea(
            child: Column(children: [
              Row(
                children: [
                  const Expanded(child: SizedBox(width: 16)),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.PROFILE, preventDuplicates: true);
                      },
                      child: const Icon(Icons.perm_identity,
                          color: Color(0xff667C8A))),
                  const SizedBox(width: 23)
                ],
              ),
            ])));
  }
}
