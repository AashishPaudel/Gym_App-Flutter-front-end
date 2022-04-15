import 'package:get/get.dart';
import 'package:gym_app/app/modules/check_in/controllers/check_in_controller.dart';
import 'package:gym_app/app/modules/gym/controllers/gym_controller.dart';
import 'package:gym_app/app/modules/gym_map/controllers/gym_map_controller.dart';
import 'package:gym_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:gym_app/app/modules/subscription/controllers/subscription_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<SubscriptionController>(
      () => SubscriptionController(),
    );
    Get.lazyPut<GymController>(
      () => GymController(),
    );
    Get.lazyPut<CheckInController>(
      () => CheckInController(),
    );
  }
}
