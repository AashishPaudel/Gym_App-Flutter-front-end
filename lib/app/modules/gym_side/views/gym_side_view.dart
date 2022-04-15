import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gym_app/app/config/theme_colors.dart';
import 'package:gym_app/app/data/repositories/session_repository.dart';
import 'package:gym_app/app/data/repositories/user_repository.dart';
import 'package:gym_app/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/gym_side_controller.dart';
import 'edit_gym.dart';
import 'gym_history.dart';

class GymSideView extends GetView<GymSideController> {
  const GymSideView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gym Profile',
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
                                controller.getGymDetails(),
                                controller.getCheckInHistory()
                              ]);
                              await controller.updateGymData();
                              controller.refreshValue.value = false;
                            },
                            child: const Icon(Icons.refresh,
                                color: Color(0xff667C8A))),
                        const Expanded(child: SizedBox(width: 16)),
                        GestureDetector(
                            onTap: () async {
                              Get.toNamed(EditGym.id,
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
                    // Center(
                    //   child: Image.asset(
                    //     'assets/profile.png',
                    //     height: Get.width * 0.3,
                    //     width: Get.width * 0.3,
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    Image.network(
                      '${controller.qrCode}',
                      loadingBuilder: (BuildContext context,
                          Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes !=
                                  null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                                  : null,
                            ));
                      },
                      errorBuilder: (BuildContext context,
                          Object exception, StackTrace stackTrace) {
                        return const Icon(Icons.error);
                      },
                      width: Get.width * 0.65,
                      fit: BoxFit.fill,
                    ),
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
                                      controller.companyName.value == null
                                          ? 'XX'
                                          : controller.companyName.value == ''
                                              ? 'XX'
                                              : controller.companyName.value,
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
                                  'Description:',
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
                                      controller.description.value == null ||
                                              controller.description.value ==
                                                  "null" ||
                                              controller.description.value == ""
                                          ? "XX"
                                          : controller.description.value,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                                  'Total \nEarning:',
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
                                      controller.totalEarning.value == null
                                          ? 'XX'
                                          : controller.totalEarning.value == ''
                                              ? 'XX'
                                              : controller.totalEarning.value,
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
                              Get.toNamed(GymHistory.id,
                                  preventDuplicates: true);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Total \nCheck-Ins',
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
                                    controller.historyList == null
                                        ? 'XX'
                                        : controller.historyList.isEmpty
                                        ? 'XX'
                                        : controller.historyList.length.toString(),
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
