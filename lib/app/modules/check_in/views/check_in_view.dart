import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:get/get.dart';
import 'package:gym_app/app/config/theme_colors.dart';
import 'package:gym_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:gym_app/app/widgets/custom_snackbar.dart';
import 'package:gym_app/app/widgets/top_snack_bar.dart';

import '../controllers/check_in_controller.dart';

class CheckInView extends StatefulWidget {
  const CheckInView({Key key}) : super(key: key);

  @override
  _CheckInViewState createState() => _CheckInViewState();
}

class _CheckInViewState extends State<CheckInView> {
  final CheckInController controller = Get.find();
  final ProfileController profileController = Get.find();

  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<String> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      setState(() {
        _scanBarcode = barcodeScanRes;
      });
    }
    return barcodeScanRes;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Check-In',
            style: Get.textTheme.headline5.copyWith(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xffE5E5E5).withOpacity(0.0),
        ),
        backgroundColor: const Color(0xffE5E5E5).withOpacity(0.5),
        body: SafeArea(
            child: Column(children: [
          // Row(
          //   children: [
          //     const Expanded(child: SizedBox(width: 16)),
          //     GestureDetector(
          //         onTap: () async {
          //           // Get.toNamed(Routes.PROFILE, preventDuplicates: true);
          //           UserRepository repository = UserRepository(
          //               prefs: await SharedPreferences.getInstance());
          //           await repository.logout();
          //           SessionRepository.instance.setAccessToken(null);
          //           Get.offAllNamed(Routes.AUTH);
          //         },
          //         child: const Icon(Icons.logout, color: Color(0xff667C8A))),
          //     const SizedBox(width: 23)
          //   ],
          // ),
          Image.asset(
            'assets/logo.png',
            height: Get.width * 0.6,
            width: Get.width * 0.8,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 37),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              "Click the Check-In button to open QR scanner.",
              textAlign: TextAlign.center,
              style: Get.textTheme.headline5.copyWith(
                  color: const Color(0xff435D6B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
          ),
          const SizedBox(height: 37),
          GestureDetector(
            onTap: () async {
              final url = await scanQR();
              if (Uri.parse(url).isAbsolute) {
                if (url.contains("check-in")) {
                  final status = await controller.initiateCheckIn(url);
                  if(status){
                    showTopSnackBar(
                      context,
                      const CustomSnackBar.success(
                        message:
                        "Successfully checked in. Enjoy!",
                      ),
                    );
                    profileController.refreshValue.value = true;
                    await Future.wait([
                      profileController.getUserDetails(),
                      profileController.getCustomerDetails(),
                      profileController.getSubscriptionDetails(),
                      profileController.getCheckInHistory(),
                    ]);
                    await profileController.updateUserData();
                    profileController.refreshValue.value = false;
                  }else{
                    showTopSnackBar(
                      context,
                      CustomSnackBar.error(
                        message:
                        "${controller.authError}",
                      ),
                    );
                  }
                }else{
                  showTopSnackBar(
                    context,
                    const CustomSnackBar.error(
                      message:
                      "Invalid QR.",
                    ),
                  );
                }
              }else{
                showTopSnackBar(
                  context,
                  const CustomSnackBar.info(
                    message:
                    "Check-in cancelled!",
                  ),
                );
              }
            },
            child: Container(
              width: Get.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 22),
              margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 22),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.qr_code_scanner_rounded,
                      color: Colors.white),
                  const SizedBox(width: 13),
                  Text(
                    'Check-In',
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headline5.copyWith(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
        ])));
  }
}
