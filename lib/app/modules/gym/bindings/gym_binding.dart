import 'package:get/get.dart';

import '../controllers/gym_controller.dart';

class GymBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GymController>(
      () => GymController(),
    );
  }
}
