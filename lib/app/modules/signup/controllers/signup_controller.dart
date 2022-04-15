import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/data/repositories/auth_repository.dart';
import 'package:gym_app/app/data/repositories/session_repository.dart';
import 'package:gym_app/app/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  final progressStatus = false.obs;

  showProgressBar() => progressStatus.value = true;

  hideProgressBar() => progressStatus.value = false;
  UserRepository _userRepository;
  SharedPreferences _sharedPreferences;

  TextEditingController usernameInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController addressInputController = TextEditingController();
  TextEditingController phoneInputController = TextEditingController();

  String username, password, address, email, phone;
  String authError = '';
  String errorMessage = '';
  final usernameError = ''.obs;
  final emailError = ''.obs;
  final addressError = ''.obs;
  final passwordError = ''.obs;
  final phoneError = ''.obs;
  final passwordInvisible = true.obs;
  final confirmPasswordInvisible = true.obs;
  final signUpButtonEnabled = false.obs;

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

  setUsernameError(String error) => usernameError.value = error;

  setEmailError(String error) => emailError.value = error;

  void setPasswordError(String error) => passwordError.value = error;

  void setPhoneError(String error) => phoneError.value = error;

  void setAddressError(String error) => addressError.value = error;

  void changePasswordVisibility(bool status) =>
      passwordInvisible.value = status;

  void changeConfirmPasswordVisibility(bool status) =>
      confirmPasswordInvisible.value = status;

  bool validate() {
    bool isValid = false;
    username = usernameInputController.text;
    email = emailInputController.text;
    password = passwordInputController.text;
    address = addressInputController.text;
    phone = phoneInputController.text;
    if (username.isEmpty) {
      errorMessage = 'Username cannot be empty.';
      setUsernameError('Username cannot be empty.');
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      errorMessage = 'Email format is not correct';
      setEmailError('Email format is not correct');
    } else if (phone.length != 10) {
      errorMessage = 'Phone number format is not correct';
      setPhoneError('Password and Re-enter password do not match.');
    } else if (!RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$')
        .hasMatch(phone)) {
      errorMessage = 'Phone must contain numeric value';
    } else if (password.length < 8) {
      errorMessage = 'Password must contain at least 8 characters.';
      setPasswordError('Password must contain at least 8 characters.');
    } else if (address.length < 5) {
      errorMessage = 'Please enter a valid address.';
      setAddressError('Please enter a valid address.');
    } else {
      isValid = true;
    }
    return isValid;
  }

  checkSignUpButtonEnabled() {
    username = usernameInputController.text;
    email = emailInputController.text;
    password = passwordInputController.text;
    address = addressInputController.text;
    signUpButtonEnabled.value = (username.length > 3 &&
            email.length > 4 &&
            password.length > 4 &&
            address.length > 4)
        ? signUpButtonEnabled.value = true
        : false;
  }

  Future<bool> signUpUser() async {
    showProgressBar();
    final status = await AuthRepository.registerUser(
            username, email, password, address, phone)
        .catchError((error) {
      if (error.contains('full header')) {
        authError =
            'Internet failed to establish proper connection. Try again.';
      } else {
        authError = error;
      }
    });
    if (status == null) {
      return false;
    }
    //final detailStatus = await getUserDetails();
    final detailStatus = true;
    hideProgressBar();
    if (detailStatus)
      return true;
    else
      return false;
  }

  @override
  void onClose() {}
}
