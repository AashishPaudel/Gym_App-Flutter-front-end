import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/data/model/profile_update.dart';
import 'package:gym_app/app/data/repositories/session_repository.dart';
import 'package:gym_app/app/data/request/profile_request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  final authError = ''.obs;
  final name = ''.obs;
  final subscription = ''.obs;
  final remainingCheckIns = ''.obs;
  final totalCheckIns = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final address = ''.obs;
  final gender = ''.obs;
  final profilePic = ''.obs;
  final refreshValue = false.obs;
  final historyRefreshValue = false.obs;
  final historyList = [].obs;
  final imagePath = ''.obs;

  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;

  String editName, editAddress;
  final saveButton = false.obs;
  final errorMessage = ''.obs;

  File _imageFile;
  PickedFile pickedFile;

  File get imageFile => _imageFile;

  @override
  void onInit() {
    super.onInit();
  }

  checkSaveButton() {
    editName = nameController.value.text.trim();
    editAddress = addressController.value.text.trim();
    saveButton.value = (editName.length > 2 && editAddress.length > 2)
        ? saveButton.value = true
        : false;
  }

  void updateImageFile(image) {
    _imageFile = image;
    update();
  }

  setPickedFile(file) => pickedFile = file;

  bool validateProfileSave() {
    bool isValid = false;
    editName = nameController.value.text;
    editAddress = addressController.value.text;
    if (editName.length < 3) {
      errorMessage.value = 'Name is incomplete';
    } else if (editAddress.length < 3) {
      errorMessage.value = 'Address is incomplete';
    } else {
      isValid = true;
    }
    return isValid;
  }

  updateUserData() {
    if (SessionRepository.instance.user != null) {
      name.value = SessionRepository.instance.user.name;
      nameController.value.text = name.value;
      email.value = SessionRepository.instance.user.email ?? '';
      emailController.value.text = email.value;
      phone.value = SessionRepository.instance.user.phone;
      phoneController.value.text = phone.value;
      address.value = SessionRepository.instance.user.address;
      addressController.value.text = address.value;
      if (SessionRepository.instance.user.image != null) {
        imagePath.value = SessionRepository.instance.user.image;
      } else {
        imagePath.value = '';
      }
      // addressController.value.text = address.value
      // if(SessionRepository.instance.user.image){}
    }
    if (SessionRepository.instance.customer != null) {
      remainingCheckIns.value =
          SessionRepository.instance.customer.remainingCheckIns.toString();
      totalCheckIns.value =
          SessionRepository.instance.customer.totalCheckIns.toString();
    }
    if (SessionRepository.instance.subscription != null) {
      subscription.value = SessionRepository.instance.subscription.toString();
    }

    // profilePic.value = SessionRepository.instance.user.;
  }

  Future<bool> getUserDetails() async {
    var response = await ProfileRequest.getUserDetail().catchError((error) {
      authError.value = error;
    });
    if (response == null) {
      return false;
    }
    return true;
  }

  Future<bool> getCustomerDetails() async {
    var response =
        await ProfileRequest.getCustomerDetails().catchError((error) {
      authError.value = error;
    });
    if (response == null) {
      return false;
    }
    return true;
  }

  Future<bool> getSubscriptionDetails() async {
    var response =
        await ProfileRequest.getSubscriptionDetails().catchError((error) {
      authError.value = error;
    });
    if (response == null) {
      return false;
    }
    return true;
  }

  Future<bool> getCheckInHistory() async {
    var response = await ProfileRequest.getCheckInHistory().catchError((error) {
      authError.value = error;
    });
    if (response == null) {
      return false;
    } else if (response.isEmpty) {
      return false;
    }
    historyList.value = response;
    return true;
  }

  Future<bool> updateUserDetails() async {
    File image;
    if (_imageFile != null) {
      final Directory dir = await getApplicationDocumentsDirectory();
      String dirPath = dir.path;
      Uuid uuid = Uuid();
      String first = uuid.v4();
      String second = uuid.v1();
      final String filePath = '$dirPath/$first$second.jpg';
      image = await _imageFile.copy(filePath);
    }

    ProfileUpdateRequest user = ProfileUpdateRequest(
        name: nameController.value.text,
        address: addressController.value.text,
        image: image);

    final status =
        await ProfileRequest.updateUserDetail(user).catchError((error) {
      errorMessage.value = error;
    });

    if (status == null) {
      return false;
    }

    // profileUpdated = true;
    return true;
  }
}
