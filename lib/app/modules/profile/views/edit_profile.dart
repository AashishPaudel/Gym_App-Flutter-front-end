import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/config/theme_colors.dart';
import 'package:gym_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:gym_app/app/widgets/custom_snackbar.dart';
import 'package:gym_app/app/widgets/custom_input_textfield.dart';
import 'package:gym_app/app/widgets/top_snack_bar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfile extends StatelessWidget {
  final ProfileController controller = Get.find();
  static String id = '/edit';

  EditProfile({Key key}) : super(key: key);

  final FocusNode nameNode = FocusNode();
  final FocusNode phoneNode = FocusNode();
  final FocusNode addressNode = FocusNode();
  final FocusNode emailNode = FocusNode();

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(
                      Icons.photo_library,
                      color: primaryColor,
                    ),
                    title: Text('Photo Library'.tr,
                        style: Get.textTheme.headline5
                            .copyWith(color: primaryColor)),
                    onTap: () async {
                      final status = await Permission.storage.request();
                      if (status.isGranted) {
                        _imagePickerCallBack(ImageSource.gallery);
                        Navigator.of(context).pop();
                      } else if (status.isPermanentlyDenied) {
                        openAppSettings();
                      } else {}
                    }),
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: primaryColor,
                  ),
                  title: Text('Camera'.tr,
                      style: Get.textTheme.headline5
                          .copyWith(color: primaryColor)),
                  onTap: () async {
                    final status = await Permission.storage.request();
                    if (status.isGranted) {
                      _imagePickerCallBack(ImageSource.camera);
                      Navigator.of(context).pop();
                    } else if (status.isPermanentlyDenied) {
                      openAppSettings();
                    } else {}
                  },
                ),
              ],
            ),
          );
        });
  }

  void _imagePickerCallBack(ImageSource imageSource) async {
    try {
      PickedFile image =
          await ImagePicker().getImage(source: imageSource, imageQuality: 85);
      if (image != null) {
        controller.setPickedFile(image);
        cropPickedImage(image.path);
      } else {}
    } catch (e) {}
  }

  cropPickedImage(filePath) async {
    File croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath,
        androidUiSettings: const AndroidUiSettings(
          toolbarColor: primaryColor,
          toolbarWidgetColor: Colors.white,
          hideBottomControls: true,
        ),
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    if (croppedImage != null) {
      controller.updateImageFile(croppedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: Obx(() => !controller.historyRefreshValue.value
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 4,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 8, bottom: 8, right: 6),
                                    child: const Center(
                                        child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                      size: 18,
                                    )),
                                  )),
                            ),
                            const Expanded(child: SizedBox())
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.032,
                        ),
                      GetBuilder<ProfileController>(
                        builder: (controller) => GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: SizedBox(
                            height: Get.width * 0.5,
                            width: Get.width,
                            child: Center(
                                child: SizedBox(
                                  height: Get.width * 0.35,
                                  width: Get.width * 0.35,
                                  child: controller.imageFile != null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(controller.imageFile,
                                        height: Get.width * 0.35,
                                        width: Get.width * 0.35,
                                        fit: BoxFit.cover),
                                  )
                                      : controller.imagePath == null
                                      ? Icon(
                                    Icons.add_a_photo_rounded,
                                    color: Colors.grey[800],
                                  )
                                      : Stack(
                                    children: [
                                      controller.imagePath.value == null && controller.imagePath.value != '' ?ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          '${controller.imagePath}',
                                          fit: BoxFit.cover,
                                        ),
                                      ) : Image.asset(
                              'assets/profile.png',
                              height: Get.width * 0.3,
                              width: Get.width * 0.3,
                              fit: BoxFit.fill,
                              color: Colors.white,
                            ),
                                      const Align(
                                        alignment: Alignment.bottomRight,
                                        child: Icon(
                                          Icons.add_a_photo_rounded,
                                          color: Colors.black,
                                          size: 35,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          'Name',
                          textAlign: TextAlign.center,
                          style: Get.textTheme.headline5.copyWith(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(height: Get.height * 0.005),
                        CustomInputField(
                          focusNode: nameNode,
                          textInputType: TextInputType.name,
                          onChanged: (_) {
                          },
                          controller: controller.nameController.value,
                          inputColor: const Color(0xffC4C4C4),
                          radius: 0,
                          focusedRadius: 0,
                        ),
                        SizedBox(height: Get.height * 0.03),
                        Text(
                          'Email',
                          textAlign: TextAlign.center,
                          style: Get.textTheme.headline5.copyWith(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(height: Get.height * 0.005),
                        CustomInputField(
                          focusNode: emailNode,
                          enabled: false,
                          textInputType: TextInputType.emailAddress,
                          onChanged: (_) {
                          },
                          controller: controller.emailController.value,
                          inputColor: const Color(0xffC4C4C4),
                          radius: 0,
                          focusedRadius: 0,
                        ),
                        SizedBox(height: Get.height * 0.03),
                        Text(
                          'Phone',
                          textAlign: TextAlign.center,
                          style: Get.textTheme.headline5.copyWith(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(height: Get.height * 0.005),
                        CustomInputField(
                          focusNode: phoneNode,
                          enabled: false,
                          textInputType: TextInputType.phone,
                          onChanged: (_) {
                          },
                          controller: controller.phoneController.value,
                          inputColor: const Color(0xffC4C4C4),
                          radius: 0,
                          focusedRadius: 0,
                        ),
                        SizedBox(height: Get.height * 0.03),
                        Text(
                          'Address',
                          textAlign: TextAlign.center,
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
                          },
                          controller: controller.addressController.value,
                          inputColor: const Color(0xffC4C4C4),
                          radius: 0,
                          focusedRadius: 0,
                        ),
                        SizedBox(height: Get.height * 0.03),
                        GestureDetector(
                          onTap: () async {
                            final status = await controller.updateUserDetails();
                            if (status) {
                              final resStatus = await controller.getUserDetails();
                              controller.updateUserData();
                              showTopSnackBar(
                                context,
                                const CustomSnackBar.success(
                                  message: "Profile updated successfully.",
                                ),
                              );

                              Get.back();
                            } else {

                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message: "${controller.errorMessage}",
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: Get.width * 0.5,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 8),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Update',
                              textAlign: TextAlign.center,
                              style: Get.textTheme.headline5.copyWith(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
        ));
  }
}
