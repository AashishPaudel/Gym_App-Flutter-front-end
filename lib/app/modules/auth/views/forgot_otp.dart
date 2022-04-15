import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input_textfield.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/top_snack_bar.dart';
import '../controllers/auth_controller.dart';
import 'change_password.dart';

class ForgetOtp extends GetView<AuthController> {
  static String id = '/forget_otp';

  ForgetOtp({Key key}) : super(key: key);

  final FocusNode otpNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height * 0.1),
                        Text(
                          'OTP Confirmation',
                          style: Get.textTheme.headline5.copyWith(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 28),
                        ),
                        SizedBox(height: Get.height * 0.055),
                        Text(
                          'Enter your otp code',
                          style: Get.textTheme.headline5.copyWith(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                        SizedBox(height: Get.height * 0.09),
                        Text(
                          'OTP',
                          style: Get.textTheme.headline5.copyWith(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(height: Get.height * 0.005),
                        CustomInputField(
                          focusNode: otpNode,
                          textInputType: TextInputType.number,
                          onChanged: (_) {
                            controller.checkOTPButtonEnabled();
                          },
                          onSubmit: (_) => node.unfocus(),
                          controller: controller.otpController,
                          inputColor: const Color(0xffC4C4C4),
                          radius: 0,
                          focusedRadius: 0,
                        ),
                        SizedBox(height: Get.height * 0.09),
                        SizedBox(
                          width: 150,
                          child: Obx(() => CustomButton(
                            radius: 10,
                            onPressed: controller.otpButtonEnabled.value
                                ? () async {
                              controller.otpButtonEnabled.value = false;
                              if (controller.validateOtp()) {
                                Get.toNamed(ChangePassword.id, preventDuplicates: true);
                              } else {
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message:
                                    "Error. ${controller.forgotError}",
                                  ),
                                );
                                controller.otpButtonEnabled.value =
                                true;
                              }
                            }
                                : null,
                            text: 'Verify',
                            backgroundColor: controller.otpButtonEnabled.value
                                ? const Color(0xff6779BA)
                                : Colors.grey,
                          )),
                        ),
                        SizedBox(height: Get.height * 0.05),
                      ],
                    )
                )
            )
        ));
  }
}
