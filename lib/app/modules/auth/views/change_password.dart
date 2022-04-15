import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input_textfield.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/password_input_textfield.dart';
import '../../../widgets/top_snack_bar.dart';
import '../controllers/auth_controller.dart';
import 'forgot_otp.dart';

class ChangePassword extends GetView<AuthController> {
  static String id = '/change_password';

  ChangePassword({Key key}) : super(key: key);

  final FocusNode passwordNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();

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
                    'Change Password',
                    style: Get.textTheme.headline5.copyWith(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 28),
                  ),
                  SizedBox(height: Get.height * 0.055),
                  Text(
                    'Enter your new password',
                    style: Get.textTheme.headline5.copyWith(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                  SizedBox(height: Get.height * 0.09),
                  Text(
                    'Password',
                    style: Get.textTheme.headline5.copyWith(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(height: Get.height * 0.005),
                  Obx(() => PasswordTextField(
                    textInputType: TextInputType.visiblePassword,
                    labelText: 'Password'.tr,
                    hintText: 'Enter password'.tr,
                    focusNode: passwordNode,
                    onChanged: (_) {
                      controller.checkForgetPasswordEnabled();
                    },
                    onSubmit: (_) => node.requestFocus(confirmPasswordNode),
                    suffix: IconButton(
                        icon: Icon(
                          controller.newPasswordInvisible.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 18,
                        ),
                        color: passwordNode.hasFocus
                            ? primaryColor
                            : passwordNode.hasFocus &&
                            controller.newPasswordError != null
                            ? Colors.red
                            : Colors.grey,
                        onPressed: () =>
                            controller.changeNewPasswordVisibility(
                                !controller.newPasswordInvisible.value)),
                    obscureText: controller.newPasswordInvisible.value,
                    errorText: controller.newPasswordError.value,
                    controller: controller.newPasswordController,
                  )),
                  SizedBox(height: Get.height * 0.05),
                  Text(
                    'Confirm Password',
                    style: Get.textTheme.headline5.copyWith(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(height: Get.height * 0.005),
                  Obx(() => PasswordTextField(
                    textInputType: TextInputType.visiblePassword,
                    labelText: 'Password'.tr,
                    hintText: 'Enter password'.tr,
                    focusNode: confirmPasswordNode,
                    onChanged: (_) {
                      controller.checkForgetPasswordEnabled();
                    },
                    onSubmit: (_) => node.unfocus(),
                    suffix: IconButton(
                        icon: Icon(
                          controller.confirmPasswordInvisible.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 18,
                        ),
                        color: passwordNode.hasFocus
                            ? primaryColor
                            : passwordNode.hasFocus &&
                            controller.newPasswordError != null
                            ? Colors.red
                            : Colors.grey,
                        onPressed: () =>
                            controller.changeConfirmPasswordVisibility(
                                !controller.confirmPasswordInvisible.value)),
                    obscureText: controller.confirmPasswordInvisible.value,
                    errorText: controller.newPasswordError.value,
                    controller: controller.confirmPasswordController,
                  )),
                  SizedBox(height: Get.height * 0.05),
                  SizedBox(
                    width: 150,
                    child: Obx(() => CustomButton(
                      radius: 10,
                      onPressed: controller.forgetButtonEnabled.value
                          ? () async {
                        controller.forgetButtonEnabled.value = false;
                        if (controller.validateChangePassword()) {
                          final status =
                          await controller.changePassword();
                          if (status) {
                            showTopSnackBar(
                              context,
                              const CustomSnackBar.success(
                                message: "Passwords changed successfully",
                              ),
                            );
                            controller.forgetButtonEnabled.value =
                            true;
                            Get.offAllNamed(Routes.AUTH);
                          } else {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.error(
                                message: controller.newPasswordError.value,
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
                              "Error. ${controller.newPasswordError}",
                            ),
                          );
                          controller.forgetButtonEnabled.value =
                          true;
                        }
                      }
                          : null,
                      text: 'Change',
                      backgroundColor: controller.forgetButtonEnabled.value
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
