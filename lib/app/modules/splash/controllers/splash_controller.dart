import 'package:get/get.dart';
import 'package:gym_app/app/data/repositories/session_repository.dart';
import 'package:gym_app/app/data/repositories/user_repository.dart';
import 'package:gym_app/app/routes/app_pages.dart';
import 'package:gym_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController with StateMixin<dynamic> {
  //TODO: Implement SplashController

  final count = 0.obs;

  @override
  void onInit() {
    loader();
    super.onInit();
  }

  loader() async {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      UserRepository repository = UserRepository(prefs: sharedPreferences);
      final logged = await repository.isLoggedIn();
      if (logged) {
        if (await storage.read(key: "login_type") == "customer") {
          Get.offAndToNamed(Routes.HOME);
        } else {
          Get.offAndToNamed(Routes.GYM_SIDE);
        }
      } else {
        Get.offAndToNamed(Routes.AUTH);
      }
      change(value, status: RxStatus.success());
    });
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}
