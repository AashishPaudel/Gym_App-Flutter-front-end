import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gym_app/app/config/theme_colors.dart';
import 'package:gym_app/app/data/repositories/session_repository.dart';
import 'package:gym_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:gym_app/app/routes/app_pages.dart';
import 'package:gym_app/app/widgets/custom_button.dart';
import 'package:gym_app/app/widgets/custom_snackbar.dart';
import 'package:gym_app/app/widgets/custom_input_textfield.dart';
import 'package:gym_app/app/widgets/password_input_textfield.dart';
import 'package:gym_app/app/widgets/top_snack_bar.dart';

class AuthGymView extends GetView<AuthController> {
  static String id = '/auth_gym';

  final FocusNode usernameNode = FocusNode();
  final FocusNode passwordNode = FocusNode();


  AuthGymView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height * 0.1),
                        Text(
                          'Sign In',
                          style: Get.textTheme.headline5.copyWith(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 28),
                        ),
                        SizedBox(height: Get.height * 0.055),
                        Text(
                          'Enter your Username and Password',
                          style: Get.textTheme.headline5.copyWith(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                        SizedBox(height: Get.height * 0.09),
                        Text(
                          'Email         ',
                          style: Get.textTheme.headline5.copyWith(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(height: Get.height * 0.005),
                        CustomInputField(
                          focusNode: usernameNode,
                          textInputType: TextInputType.emailAddress,
                          onChanged: (_) {
                            controller.setUsernameError(null);
                            controller.checkLoginButtonEnabled();
                          },
                          onSubmit: (_) => node.requestFocus(passwordNode),
                          errorText: controller.usernameError.value,
                          controller: controller.usernameInputController,
                          inputColor: const Color(0xffC4C4C4),
                          radius: 0,
                          focusedRadius: 0,
                        ),
                        SizedBox(height: Get.height * 0.05),
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
                            controller.checkLoginButtonEnabled();
                            controller.setPasswordError(null);
                          },
                          onSubmit: (_) => node.unfocus(),
                          suffix: IconButton(
                              icon: Icon(
                                controller.passwordInvisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 18,
                              ),
                              color: passwordNode.hasFocus
                                  ? primaryColor
                                  : passwordNode.hasFocus &&
                                  controller.passwordError != null
                                  ? Colors.red
                                  : Colors.grey,
                              onPressed: () =>
                                  controller.changePasswordVisibility(
                                      !controller.passwordInvisible.value)),
                          obscureText: controller.passwordInvisible.value,
                          errorText: controller.passwordError.value,
                          controller: controller.passwordInputController,
                        )),
                        SizedBox(height: Get.height * 0.05),
                        SizedBox(
                          width: 150,
                          child: Obx(() => CustomButton(
                            radius: 10,
                            onPressed: controller.loginButtonEnabled.value
                                ? () async {
                              controller.loginButtonEnabled.value = false;
                              if (controller.validate()) {
                                final status =
                                await controller.loginGym();
                                if (status) {
                                  showTopSnackBar(
                                    context,
                                    const CustomSnackBar.success(
                                      message: "Login successful",
                                    ),
                                  );
                                  SessionRepository.instance.setCustomerLogin(false);
                                  Get.offAllNamed(Routes.GYM_SIDE);
                                  controller.loginButtonEnabled.value =
                                  true;
                                } else {
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message: controller.authError.value,
                                    ),
                                  );
                                  controller.loginButtonEnabled.value =
                                  true;
                                }
                              } else {
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message:
                                    "Error. ${controller.authError}",
                                  ),
                                );
                                controller.loginButtonEnabled.value =
                                true;
                              }
                            }
                                : null,
                            text: 'Login',
                            backgroundColor: controller.loginButtonEnabled.value
                                ? const Color(0xff6779BA)
                                : Colors.grey,
                          )),
                        ),
                        SizedBox(height: Get.height * 0.05),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
