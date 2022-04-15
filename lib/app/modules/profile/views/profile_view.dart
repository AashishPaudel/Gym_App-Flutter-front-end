import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gym_app/app/config/theme_colors.dart';
import 'package:gym_app/app/data/repositories/session_repository.dart';
import 'package:gym_app/app/data/repositories/user_repository.dart';
import 'package:gym_app/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/profile_controller.dart';
import 'edit_profile.dart';
import 'history.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: Get.textTheme.headline5.copyWith(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Obx(() => !controller.refreshValue.value
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 23),
                        GestureDetector(
                            onTap: () async {
                              controller.refreshValue.value = true;
                              await Future.wait([
                                controller.getUserDetails(),
                                controller.getCustomerDetails(),
                                controller.getSubscriptionDetails(),
                                controller.getCheckInHistory(),
                              ]);
                              await controller.updateUserData();
                              controller.refreshValue.value = false;
                            },
                            child: const Icon(Icons.refresh,
                                color: Color(0xff667C8A))),
                        const Expanded(child: SizedBox(width: 16)),
                        GestureDetector(
                            onTap: () async {
                              Get.toNamed(EditProfile.id,
                                  preventDuplicates: true);
                            },
                            child: const Icon(Icons.edit,
                                color: Color(0xff667C8A))),
                        const SizedBox(width: 23)
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.032,
                    ),
                    Obx(() => controller.imagePath.value !=
                        null && controller.imagePath.value != ''
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                      controller.imagePath.value,
                      loadingBuilder: (BuildContext context,
                            Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress
                                    .expectedTotalBytes !=
                                    null
                                    ? loadingProgress
                                    .cumulativeBytesLoaded /
                                    loadingProgress
                                        .expectedTotalBytes
                                    : null,
                              ));
                      },
                      errorBuilder: (BuildContext context,
                            Object exception,
                            StackTrace stackTrace) {
                          return const Icon(Icons.error);
                      },
                      height: Get.width * 0.3,
                      width: Get.width * 0.3,
                      fit: BoxFit.fill,
                    ),
                        )
                        : Image.asset(
                      'assets/profile.png',
                      height: Get.width * 0.3,
                      width: Get.width * 0.3,
                      fit: BoxFit.fill,
                    )),
                    // Center(
                    //   child: Image.asset(
                    //     'assets/profile.png',
                    //     height: Get.width * 0.3,
                    //     width: Get.width * 0.3,
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 22),
                      padding: const EdgeInsets.symmetric(vertical: 31),
                      decoration: BoxDecoration(
                          color: const Color(0xffE5E5E5).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(0)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'User Name:',
                                  textAlign: TextAlign.center,
                                  style: Get.textTheme.headline5.copyWith(
                                      color: const Color(0xff435D6B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Obx(() => Text(
                                      controller.name.value == null
                                          ? 'XX'
                                          : controller.name.value == ''
                                              ? 'XX'
                                              : controller.name.value,
                                      style: Get.textTheme.headline5.copyWith(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Subscription:',
                                  textAlign: TextAlign.center,
                                  style: Get.textTheme.headline5.copyWith(
                                      color: const Color(0xff435D6B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Obx(() => Text(
                                      controller.subscription.value == null ||
                                              controller.subscription.value ==
                                                  "null" ||
                                              controller.subscription.value ==
                                                  ""
                                          ? "XX"
                                          : controller.subscription.value,
                                      maxLines: 2,
                                      style: Get.textTheme.headline5.copyWith(
                                          color: const Color(0xff000000),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Remaining \nCheck-Ins:',
                                  textAlign: TextAlign.center,
                                  style: Get.textTheme.headline5.copyWith(
                                      color: const Color(0xff435D6B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Obx(() => Text(
                                      controller.remainingCheckIns.value == null
                                          ? 'XX'
                                          : controller.remainingCheckIns
                                                      .value ==
                                                  ''
                                              ? 'XX'
                                              : controller
                                                  .remainingCheckIns.value,
                                      style: Get.textTheme.headline5.copyWith(
                                          color: const Color(0xff000000),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(CheckInHistory.id,
                                  preventDuplicates: true);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Total \nCheck-Ins:',
                                  textAlign: TextAlign.center,
                                  style: Get.textTheme.headline5.copyWith(
                                      color: const Color(0xff435D6B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                )),
                                Expanded(
                                  child: Obx(() => Text(
                                        controller.totalCheckIns.value == null
                                            ? 'XX'
                                            : controller.totalCheckIns.value ==
                                                    ''
                                                ? 'XX'
                                                : controller
                                                    .totalCheckIns.value,
                                        style: Get.textTheme.headline5.copyWith(
                                            color: const Color(0xff000000),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () async {
                        UserRepository repository = UserRepository(
                            prefs: await SharedPreferences.getInstance());
                        await repository.logout();
                        Get.offAllNamed(Routes.AUTH);
                      },
                      child: Container(
                        width: Get.width * 0.5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 8),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.logout,
                                size: 18, color: Colors.white),
                            const SizedBox(width: 13),
                            Text(
                              'Logout',
                              textAlign: TextAlign.center,
                              style: Get.textTheme.headline5.copyWith(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                  ],
                ),
              )
            : Center(
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.white.withOpacity(0.4),
                  child: const Center(
                    child: SizedBox(
                      height: 75,
                      width: 75,
                      child: CircularProgressIndicator(
                          strokeWidth: 8,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(primaryColor)),
                    ),
                  ),
                ),
              )),
      ),
    );
  }
}
