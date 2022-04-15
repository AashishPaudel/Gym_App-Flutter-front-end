import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/config/theme_colors.dart';
import 'package:gym_app/app/modules/gym/views/gym_view.dart';
import 'package:gym_app/app/modules/gym_side/controllers/gym_side_controller.dart';
import 'package:intl/intl.dart';

class GymHistory extends StatelessWidget {
  final GymSideController controller = Get.find();
  static String id = '/gymhistory';

  GymHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => !controller.historyRefreshValue.value
            ? Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(child: SizedBox(width: 16)),
                      GestureDetector(
                          onTap: () async {
                            controller.historyRefreshValue.value = true;
                            await controller.getCheckInHistory();
                            controller.historyRefreshValue.value = false;
                          },
                          child: const Icon(Icons.refresh,
                              color: Color(0xff667C8A))),
                      const SizedBox(width: 23)
                    ],
                  ),
                  Expanded(
                    child: controller.historyList != null &&
                            controller.historyList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(
                                left: 16, top: 20, right: 16),
                            itemBuilder: (context, index) {
                              return GymWidget(
                                  name: controller
                                      .historyList[index].customerName
                                      .toString(),
                                  description: controller
                                          .historyList[index].customerName +
                                      ' checked in'.toString(),
                                  time: DateFormat('yyyy-MM-dd hh:mm a')
                                      .format(controller
                                          .historyList[index].checkInAt)
                                      .toString());
                            },
                            itemCount: controller.historyList.length,
                          )
                        : Center(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'No check-in history.',
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
