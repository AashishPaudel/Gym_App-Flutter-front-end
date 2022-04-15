import 'package:get/get.dart';

import '../controllers/gym_side_controller.dart';

class GymSideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GymSideController>(
      () => GymSideController(),
    );
  }
}
