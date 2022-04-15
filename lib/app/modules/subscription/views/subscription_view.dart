import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gym_app/app/config/theme_colors.dart';
import '../controllers/subscription_controller.dart';
import 'subscription_details.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subscriptions',
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
        child: Obx(() => !controller.refreshValue.value
            ? Column(
                children: [
                  Row(
                    children: [
                      const Expanded(child: SizedBox(width: 16)),
                      GestureDetector(
                          onTap: () async {
                            // controller.refreshValue.value = true;
                            await controller.getSubscriptionList();
                            // controller.refreshValue.value = false;
                          },
                          child: const Icon(Icons.refresh,
                              color: Color(0xff667C8A))),
                      const SizedBox(width: 23)
                    ],
                  ),
                  Expanded(
                    child: controller.subscriptionList != null && controller.subscriptionList.isNotEmpty? ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding:
                          const EdgeInsets.only(left: 16, top: 20, right: 16),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.selectedIndex.value = index;
                            controller
                                .setSelectedSubscription(
                                controller
                                    .subscriptionList[
                                index]);
                            Get.toNamed(SubscriptionDetails.id,
                                preventDuplicates: true);
                          },
                          child: SubscriptionWidget(
                            days: controller.subscriptionList[index].validFor.toString(),
                            description: controller.subscriptionList[index].description.toString(),
                            price: controller.subscriptionList[index].price,
                          ),
                        );
                      },
                      itemCount: controller.subscriptionList.length,
                    ): Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Subscriptions are unavailable.',
                          textAlign: TextAlign.center,
                          style: Get.textTheme.headline5.copyWith(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
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

class SubscriptionWidget extends StatelessWidget {
  const SubscriptionWidget(
      {Key key,
      @required this.days,
      @required this.description,
      @required this.price})
      : super(key: key);

  final String days;
  final String description;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 70),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
              height: 86,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(15)),
              margin:
                  const EdgeInsets.symmetric(horizontal: 7.43, vertical: 6.42),
              child: Center(
                  child: Text(
                '$days Days',
                style: Get.textTheme.headline5.copyWith(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: Text(
                    description,
                    style: Get.textTheme.headline5.copyWith(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
                Text(
                  "Rs.\n$price ",
                  style: Get.textTheme.headline5.copyWith(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                const SizedBox(width: 6)
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
