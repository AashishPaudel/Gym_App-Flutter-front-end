import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/data/repositories/auth_repository.dart';
import 'package:gym_app/app/data/repositories/session_repository.dart';
import 'package:gym_app/app/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final progressStatus = false.obs;

  showProgressBar() => progressStatus.value = true;

  hideProgressBar() => progressStatus.value = false;
  UserRepository _userRepository;
  SharedPreferences _sharedPreferences;

  TextEditingController usernameInputController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String username, password, email, otp, newPassword, confirmPassword;
  final authError = ''.obs;
  final usernameError = ''.obs;
  final forgotError = ''.obs;
  final passwordError = ''.obs;
  final newPasswordError = ''.obs;
  final passwordInvisible = true.obs;
  final newPasswordInvisible = true.obs;
  final confirmPasswordInvisible = true.obs;
  final loginButtonEnabled = false.obs;
  final forgetButtonEnabled = false.obs;
  final otpButtonEnabled = false.obs;
  final changeButtonEnabled = false.obs;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();

    initializeData();
  }

  initializeData() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _userRepository = UserRepository(prefs: _sharedPreferences);
  }

  setUsernameError(String error) => authError.value = error;

  void setPasswordError(String error) => authError.value = error;

  void changePasswordVisibility(bool status) =>
      passwordInvisible.value = status;

  void changeNewPasswordVisibility(bool status) =>
      newPasswordInvisible.value = status;

  void changeConfirmPasswordVisibility(bool status) =>
      confirmPasswordInvisible.value = status;

  bool validate() {
    bool isValid = false;
    username = usernameInputController.text;
    password = passwordInputController.text;
    if (username.isEmpty) {
      setUsernameError('Username cannot be empty.');
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(username)) {
      setUsernameError('Invalid Email Address');
    } else if (password.length < 6) {
      setPasswordError('Password must contain at least 8 characters.');
    } else {
      isValid = true;
    }
    return isValid;
  }

  bool validateForget() {
    bool isValid = false;
    email = emailInputController.text;
    if (email.isEmpty) {
      forgotError.value = 'Email cannot be empty.';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      forgotError.value = 'Invalid Email Address.';
    } else {
      isValid = true;
    }
    return isValid;
  }

  bool validateOtp() {
    bool isValid = false;
    otp = otpController.text;
    if (otp.isEmpty) {
      forgotError.value = 'OTP cannot be empty.';
    } else if (otp.length != 6) {
      forgotError.value = 'Invalid OTP.';
    } else {
      isValid = true;
    }
    return isValid;
  }

  bool validateChangePassword() {
    bool isValid = false;
    newPassword = newPasswordController.text;
    confirmPassword = confirmPasswordController.text;
    if (newPassword != confirmPassword){
      newPasswordError.value = 'Passwords do not match.';
    } else if (newPassword.length < 7) {
      newPasswordError.value = 'Password must contain at least 8 characters.';
    } else if (confirmPassword.length < 7) {
      newPasswordError.value = 'Confirm password must contain at least 8 characters.';
    } else {
      isValid = true;
    }
    return isValid;
  }

  checkLoginButtonEnabled() {
    username = usernameInputController.text;
    password = passwordInputController.text;
    loginButtonEnabled.value = (username.length > 3 && password.length > 4)
        ? loginButtonEnabled.value = true
        : false;
  }

  checkForgetPasswordEnabled() {
    email = emailInputController.text;
    forgetButtonEnabled.value =
        (email.length > 3) ? forgetButtonEnabled.value = true : false;
  }

  checkOTPButtonEnabled() {
    otp = otpController.text;
    otpButtonEnabled.value =
        (otp.length > 3) ? otpButtonEnabled.value = true : false;
  }

  checkChangePasswordEnabled() {
    password = passwordInputController.text;
    confirmPassword = confirmPasswordController.text;
    changeButtonEnabled.value =
        (confirmPassword.length > 4 && password.length > 4)
            ? changeButtonEnabled.value = true
            : false;
  }

  Future<bool> loginUser() async {
    showProgressBar();
    final status = await AuthRepository.verifyLogin(username, password)
        .catchError((error) {
      authError.value = error;
    });
    if (status == null) {
      return false;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserRepository userRepository = UserRepository(prefs: sharedPreferences);
    userRepository.login();
    await userRepository.setCustomerLogin(true);
    hideProgressBar();
    return true;
  }

  Future<bool> loginGym() async {
    showProgressBar();
    final status = await AuthRepository.verifyGymLogin(username, password)
        .catchError((error) {
      authError.value = error;
    });
    if (status == null) {
      return false;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserRepository userRepository = UserRepository(prefs: sharedPreferences);
    userRepository.login();
    await userRepository.setCustomerLogin(false);
    hideProgressBar();
    return true;
  }

  Future<bool> forgetPassword() async {
    showProgressBar();
    final status =
        await AuthRepository.resetPassword(email).catchError((error) {
      forgotError.value = error;
    });
    if (status == null) {
      return false;
    }
    return true;
  }

  Future<bool> changePassword() async {
    showProgressBar();
    final status =
    await AuthRepository.changePassword(newPassword, confirmPassword, otp).catchError((error) {
      newPasswordError.value = error;
    });
    if (status == null) {
      return false;
    }
    return true;
  }

  @override
  void onClose() {}
}
