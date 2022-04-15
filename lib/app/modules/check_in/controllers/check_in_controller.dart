import 'package:get/get.dart';
import 'package:gym_app/app/data/request/dashboard_request.dart';

class CheckInController extends GetxController {
  //TODO: Implement CheckInController
  final authError = ''.obs;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> initiateCheckIn(String url) async {
    final status = await DashboardRequest.checkIn(url).catchError((error) {
      authError.value = error;
    });
    if (status == null) {
      return false;
    } else if (status is bool) {
      if (status) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
    // hideProgressBar();
  }
}
