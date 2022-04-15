import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/config/theme_colors.dart';
import 'package:gym_app/app/data/repositories/session_repository.dart';
import 'package:gym_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:gym_app/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:gym_app/app/modules/subscription/views/subscription_payment.dart';
import 'package:gym_app/app/routes/app_pages.dart';
import 'package:gym_app/app/widgets/custom_snackbar.dart';
import 'package:gym_app/app/widgets/top_snack_bar.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class SubscriptionDetails extends GetView<SubscriptionController> {
  static String id = '/detail';

  final ProfileController profileController = Get.find();

  SubscriptionDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() => !controller.loading.value
            ? Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
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
                                          left: 12,
                                          top: 8,
                                          bottom: 8,
                                          right: 6),
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
                                  "${controller.subscriptionList[controller.selectedIndex.value].validFor} Days",
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: Get.textTheme.headline5.copyWith(
                                      color: const Color(0xff000000),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                            ],
                          ),

                          // const SizedBox(height: 37),

                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: Text(
                              "${controller.subscriptionList[controller.selectedIndex.value].description}",
                              textAlign: TextAlign.center,
                              style: Get.textTheme.headline5.copyWith(
                                  color: const Color(0xff435D6B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                          const Expanded(flex: 2, child: SizedBox()),
                          Center(
                            child: Obx(() => controller
                                        .subscriptionList[
                                            controller.selectedIndex.value]
                                        .image !=
                                    null
                                ? Image.network(
                                    '${controller.subscriptionList[controller.selectedIndex.value].image}',
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
                                      return Icon(Icons.error);
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
                          const Expanded(flex: 3, child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16, bottom: 16),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price',
                              style: Get.textTheme.headline5.copyWith(
                                  color: const Color(0xff435D6B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                            Text(
                              'Rs. ${controller.subscriptionList[controller.selectedIndex.value].price}',
                              style: Get.textTheme.headline5.copyWith(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () async {
                            controller.loading.value = true;
                            var priceSplit = controller
                                .subscriptionList[
                                    controller.selectedIndex.value]
                                .price
                                .split('.');
                            final config = PaymentConfig(
                              // Convert amount to paisa.
                              amount: int.parse(priceSplit[0]) * 100,
                              // amount: int.parse(priceSplit[0]),
                              productIdentity: controller
                                  .subscriptionList[
                                      controller.selectedIndex.value]
                                  .id
                                  .toString(),
                              productName: controller
                                  .subscriptionList[
                                      controller.selectedIndex.value]
                                  .name,
                              productUrl: 'https://www.khalti.com/#/bazaar',
                              mobile: '9868839851',
                              // mobile: SessionRepository.instance.user.phone,
                              // Not mandatory; can be used to fill mobile number field
                              mobileReadOnly:
                                  false, // Not mandatory; makes the mobile field not editable
                            );
                            // Get.toNamed(SubscriptionPayment.id, preventDuplicates: true);

                            KhaltiScope.of(context).pay(
                              config: config,
                              preferences: [PaymentPreference.khalti],
                              onSuccess: (successModel) async {
                                // Perform Server Verification

                                final status =
                                    await controller.requestVerification(
                                        successModel.token,
                                        successModel.amount);
                                if (status) {
                                  final response = await controller.subscribe();
                                  if (response) {
                                    showTopSnackBar(
                                      context,
                                      CustomSnackBar.success(
                                        message: "Thank you for subscribing!",
                                      ),
                                    );
                                    Get.offAndToNamed(Routes.HOME);
                                    profileController.refreshValue.value = true;
                                    await Future.wait([
                                      profileController.getUserDetails(),
                                      profileController.getCustomerDetails(),
                                      profileController
                                          .getSubscriptionDetails(),
                                      profileController.getCheckInHistory(),
                                    ]);
                                    await profileController.updateUserData();
                                    profileController.refreshValue.value =
                                        false;
                                    controller.loading.value = false;
                                  } else {
                                    showTopSnackBar(
                                      context,
                                      CustomSnackBar.error(
                                        message:
                                            "Subscription services are unavailable. Please contact support.",
                                      ),
                                    );
                                    controller.loading.value = false;
                                  }
                                } else {
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message:
                                          "Server verification failed. Please contact support.",
                                    ),
                                  );
                                  controller.loading.value = false;
                                }
                              },
                              onFailure: (failureModel) {
                                controller.loading.value = false;
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message:
                                        "Online payment failed. Please contact support.",
                                  ),
                                );
                                // What to do on failure?
                              },
                              onCancel: () {
                                CustomSnackBar.error(
                                  message: "Transaction cancelled.",
                                );
                                controller.loading.value = false;
                                // User manually cancelled the transaction
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 19, vertical: 22),
                            decoration: const BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                            child: Row(
                              children: [
                                const Icon(Icons.shopping_bag,
                                    color: Colors.white),
                                const SizedBox(width: 13),
                                Text(
                                  'Buy Now',
                                  style: Get.textTheme.headline5.copyWith(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
