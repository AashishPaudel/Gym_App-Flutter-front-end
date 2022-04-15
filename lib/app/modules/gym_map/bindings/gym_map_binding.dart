import 'package:get/get.dart';

import '../controllers/gym_map_controller.dart';

class GymMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GymMapController>(
      () => GymMapController(),
    );
  }
}
