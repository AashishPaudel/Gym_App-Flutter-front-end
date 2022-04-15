import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/data/model/profile_update.dart';
import 'package:gym_app/app/data/repositories/session_repository.dart';
import 'package:gym_app/app/data/request/profile_request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class GymSideController extends GetxController {
  //TODO: Implement GymSideController
  final refreshValue = false.obs;
  final authError = ''.obs;

  final companyName = ''.obs;
  final description = ''.obs;
  final totalEarning = ''.obs;
  final totalEarningCurrency = ''.obs;
  final image = ''.obs;
  final qrCode = ''.obs;

  final count = 0.obs;

  final historyRefreshValue = false.obs;
  final historyList = [].obs;

  String editGymName, editDescription;
  final saveButton = false.obs;
  final errorMessage = ''.obs;

  final nameController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;

  File _imageFile;
  PickedFile pickedFile;

  File get imageFile => _imageFile;

  @override
  void onInit() {
    callInitial();
    super.onInit();
  }

  callInitial() async {
    getCheckInHistory();
    await getGymDetails();
    updateGymData();
  }

  updateGymData() {

    if (SessionRepository.instance.gymProfile != null) {
      companyName.value = SessionRepository.instance.gymProfile.companyName;
      nameController.value.text = companyName.value;
      description.value = SessionRepository.instance.gymProfile.description;
      descriptionController.value.text = description.value;
      totalEarning.value = SessionRepository.instance.gymProfile.totalEarning;
      totalEarningCurrency.value =
          SessionRepository.instance.gymProfile.totalEarningCurrency;
      image.value = SessionRepository.instance.gymProfile.image ?? '';
      qrCode.value = SessionRepository.instance.gymProfile.qrcode;
    }
  }

  Future<bool> getGymDetails() async {
    refreshValue.value = true;
    var response = await ProfileRequest.getGymProfile().catchError((error) {
      authError.value = error;
    });
    if (response == null) {
      refreshValue.value = false;
      return false;
    }
    refreshValue.value = false;
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

  checkSaveButton() {
    editGymName = nameController.value.text.trim();
    editDescription = descriptionController.value.text.trim();
    saveButton.value = (editGymName.length > 2 && editDescription.length > 2)
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
    editGymName = nameController.value.text;
    editDescription = descriptionController.value.text;
    if (editGymName.length < 3) {
      errorMessage.value = 'Name is incomplete';
    } else if (editDescription.length < 3) {
      errorMessage.value = 'Description is incomplete';
    } else {
      isValid = true;
    }
    return isValid;
  }

  Future<bool> updateGymDetails() async {
    File image;
    if (_imageFile != null) {
      final Directory dir = await getApplicationDocumentsDirectory();
      String dirPath = dir.path;
      Uuid uuid = const Uuid();
      String first = uuid.v4();
      String second = uuid.v1();
      final String filePath = '$dirPath/$first$second.jpg';
      image = await _imageFile.copy(filePath);
    }

    ProfileGymRequest user = ProfileGymRequest(
        name: nameController.value.text,
        description: descriptionController.value.text,
        image: image);


    final status =
    await ProfileRequest.updateGymDetail(user).catchError((error) {
      authError.value = error;
    });

    if (status == null) {
      return false;
    }

    // profileUpdated = true;
    return true;
  }
}
