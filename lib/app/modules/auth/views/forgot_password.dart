
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/config/theme_colors.dart';
import 'package:gym_app/app/data/repositories/session_repository.dart';
import 'package:gym_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:gym_app/app/routes/app_pages.dart';
import 'package:gym_app/app/widgets/custom_button.dart';
import 'package:gym_app/app/widgets/custom_input_textfield.dart';
import 'package:gym_app/app/widgets/custom_snackbar.dart';
import 'package:gym_app/app/widgets/top_snack_bar.dart';

import 'forgot_otp.dart';

class ForgetPassword extends GetView<AuthController> {
  static String id = '/forget_password';
  ForgetPassword({Key key}) : super(key: key);

  final FocusNode emailNode = FocusNode();


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
                    'Forget Password',
                    style: Get.textTheme.headline5.copyWith(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 28),
                  ),
                  SizedBox(height: Get.height * 0.055),
                  Text(
                    'Enter your email address',
                    style: Get.textTheme.headline5.copyWith(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                  SizedBox(height: Get.height * 0.09),
                  Text(
                    'Email',
                    style: Get.textTheme.headline5.copyWith(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(height: Get.height * 0.005),
                  CustomInputField(
                    focusNode: emailNode,
                    textInputType: TextInputType.emailAddress,
                    onChanged: (_) {
                      controller.checkForgetPasswordEnabled();
                    },
                    onSubmit: (_) => node.unfocus(),
                    controller: controller.emailInputController,
                    inputColor: const Color(0xffC4C4C4),
                    radius: 0,
                    focusedRadius: 0,
                  ),
                  SizedBox(height: Get.height * 0.09),
                  SizedBox(
                    width: 150,
                    child: Obx(() => CustomButton(
                      radius: 10,
                      onPressed: controller.forgetButtonEnabled.value
                          ? () async {
                        controller.forgetButtonEnabled.value = false;
                        if (controller.validateForget()) {
                          final status =
                          await controller.forgetPassword();
                          if (status) {
                            showTopSnackBar(
                              context,
                              const CustomSnackBar.success(
                                message: "OTP sent successfully. Please check your email.",
                              ),
                            );
                            controller.forgetButtonEnabled.value =
                            true;
                            Get.toNamed(ForgetOtp.id, preventDuplicates: true);
                          } else {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.error(
                                message: controller.forgotError.value,
                              ),
                            );
                            controller.forgetButtonEnabled.value =
                            true;
                          }
                        } else {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message:
                              "Error. ${controller.forgotError}",
                            ),
                          );
                          controller.forgetButtonEnabled.value =
                          true;
                        }
                      }
                          : null,
                      text: 'Send',
                      backgroundColor: controller.forgetButtonEnabled.value
                          ? const Color(0xff6779BA)
                          : Colors.grey,
                    )),
                  ),
                  SizedBox(height: Get.height * 0.05),
                ],
              ),
            ),
          )),
    );
  }
}
