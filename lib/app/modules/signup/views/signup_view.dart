import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gym_app/app/config/theme_colors.dart';
import 'package:gym_app/app/routes/app_pages.dart';
import 'package:gym_app/app/widgets/custom_button.dart';
import 'package:gym_app/app/widgets/custom_snackbar.dart';
import 'package:gym_app/app/widgets/custom_input_textfield.dart';
import 'package:gym_app/app/widgets/password_input_textfield.dart';
import 'package:gym_app/app/widgets/top_snack_bar.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final FocusNode usernameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode addressNode = FocusNode();
  final FocusNode phoneNode = FocusNode();

  SignupView({Key key}) : super(key: key);

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
                    SizedBox(height: Get.height * 0.08),
                    Text(
                      'Create An \nAccount',
                      style: Get.textTheme.headline5.copyWith(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 28),
                    ),
                    SizedBox(height: Get.height * 0.04),
                    Text(
                      'Enter your personal details',
                      style: Get.textTheme.headline5.copyWith(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                    SizedBox(height: Get.height * 0.08),
                    Text(
                      'Name',
                      style: Get.textTheme.headline5.copyWith(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    SizedBox(height: Get.height * 0.005),
                    CustomInputField(
                      focusNode: usernameNode,
                      textInputType: TextInputType.name,
                      onChanged: (_) {
                        controller.setUsernameError(null);
                        controller.checkSignUpButtonEnabled();
                      },
                      onSubmit: (_) => node.requestFocus(emailNode),
                      errorText: controller.usernameError.value,
                      controller: controller.usernameInputController,
                      inputColor: const Color(0xffC4C4C4),
                      radius: 0,
                      focusedRadius: 0,
                    ),
                    SizedBox(height: Get.height * 0.03),
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
                        controller.setEmailError(null);
                        controller.checkSignUpButtonEnabled();
                      },
                      onSubmit: (_) => node.requestFocus(phoneNode),
                      errorText: controller.emailError.value,
                      controller: controller.emailInputController,
                      inputColor: const Color(0xffC4C4C4),
                      radius: 0,
                      focusedRadius: 0,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    Text(
                      'Phone',
                      style: Get.textTheme.headline5.copyWith(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    SizedBox(height: Get.height * 0.005),
                    CustomInputField(
                      focusNode: phoneNode,
                      textInputType: TextInputType.phone,
                      onChanged: (_) {
                        controller.setPhoneError(null);
                        controller.checkSignUpButtonEnabled();
                      },
                      onSubmit: (_) => node.requestFocus(addressNode),
                      errorText: controller.phoneError.value,
                      controller: controller.phoneInputController,
                      inputColor: const Color(0xffC4C4C4),
                      radius: 0,
                      focusedRadius: 0,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    Text(
                      'Address',
                      style: Get.textTheme.headline5.copyWith(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    SizedBox(height: Get.height * 0.005),
                    CustomInputField(
                      focusNode: addressNode,
                      textInputType: TextInputType.streetAddress,
                      onChanged: (_) {
                        controller.setAddressError(null);
                        controller.checkSignUpButtonEnabled();
                      },
                      onSubmit: (_) => node.requestFocus(passwordNode),
                      errorText: controller.addressError.value,
                      controller: controller.addressInputController,
                      inputColor: const Color(0xffC4C4C4),
                      radius: 0,
                      focusedRadius: 0,
                    ),
                    SizedBox(height: Get.height * 0.03),
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
                        controller.checkSignUpButtonEnabled();
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
                              controller.passwordError !=
                                  null
                              ? Colors.red
                              : Colors.grey,
                          onPressed: () => controller
                              .changePasswordVisibility(!controller
                              .passwordInvisible.value)),
                      obscureText:
                      controller.passwordInvisible.value,
                      errorText: controller.passwordError.value,
                      controller:
                      controller.passwordInputController,
                    )),
                    SizedBox(height: Get.height * 0.08),
                    SizedBox(
                      width: 150,
                      child: Obx(() => CustomButton(
                            radius: 10,
                            onPressed: controller.signUpButtonEnabled.value
                                ? () async {
                                    controller.signUpButtonEnabled.value =
                                        false;
                                    if (controller.validate()) {
                                      final status =
                                          await controller.signUpUser();
                                      if (status) {
                                        // await profileController
                                        //     .getUserDetails()
                                        //     .then((_) => profileController
                                        //     .updateUserData());
                                        showTopSnackBar(
                                            context,
                                            const CustomSnackBar.success(
                                              message:
                                                  "Thank you for registering.",
                                            ));
                                        Get.offAllNamed(Routes.AUTH);
                                        controller.signUpButtonEnabled.value =
                                            true;
                                      } else {
                                        // CustomSnackbar.showCustomSnackBar(
                                        // message: 'Login Failed!');
                                        controller.signUpButtonEnabled.value =
                                            true;
                                        showTopSnackBar(
                                            context,
                                            CustomSnackBar.error(
                                              message:
                                              controller.authError,
                                            ));
                                      }
                                    } else {
                                      controller.signUpButtonEnabled.value =
                                      true;
                                      showTopSnackBar(
                                          context,
                                          CustomSnackBar.error(
                                            message:
                                            controller.errorMessage,
                                          ));
                                    }
                                  }
                                : null,
                            text: 'Sign Up',
                            backgroundColor:
                                controller.signUpButtonEnabled.value
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
