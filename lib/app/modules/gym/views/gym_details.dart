import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/config/theme_colors.dart';
import 'package:gym_app/app/modules/gym/controllers/gym_controller.dart';
import 'package:gym_app/app/widgets/custom_snackbar.dart';
import 'package:gym_app/app/widgets/top_snack_bar.dart';

class GymDetails extends GetView<GymController> {
  static String id = '/gym_detail';

  const GymDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 4,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 8, bottom: 8, right: 6),
                                child: const Center(
                                    child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 18,
                                )),
                              )),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            "${controller.gymList[controller.selectedIndex.value].companyName}",
                            textAlign: TextAlign.center,
                            style: Get.textTheme.headline5.copyWith(
                                color: const Color(0xff000000),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.05),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        "${controller.gymList[controller.selectedIndex.value].description}",
                        textAlign: TextAlign.center,
                        style: Get.textTheme.headline5.copyWith(
                            color: const Color(0xff435D6B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    Center(
                      child: Obx(() => controller
                                  .gymList[controller.selectedIndex.value]
                                  .image !=
                              null
                          ? Image.network(
                              '${controller.gymList[controller.selectedIndex.value].image}',
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
                              width: Get.width * 1,
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              'assets/dumb.png',
                              height: Get.width * 0.5,
                              width: Get.width * 1,
                              fit: BoxFit.fill,
                            )),
                    ),
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.gymList[controller.selectedIndex.value]
                                .locationMap ==
                            null) {
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.error(
                              message: "Gym location is not available.",
                            ),
                          );
                        } else {
                          FlutterWebBrowser.openWebPage(
                            url:
                                "${controller.gymList[controller.selectedIndex.value].locationMap}",
                            customTabsOptions: const CustomTabsOptions(
                              shareState: CustomTabsShareState.on,
                              instantAppsEnabled: true,
                              showTitle: true,
                              urlBarHidingEnabled: true,
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 19, vertical: 22),
                        decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Location',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: Get.textTheme.headline5.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
