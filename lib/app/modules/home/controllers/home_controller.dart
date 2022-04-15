import 'package:get/get.dart';
import 'package:gym_app/app/data/repositories/session_repository.dart';
import 'package:gym_app/app/data/repositories/user_repository.dart';
import 'package:gym_app/app/modules/gym/controllers/gym_controller.dart';
import 'package:gym_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:gym_app/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  UserRepository userRepository;
  SharedPreferences sharedPreferences;
  SessionRepository userDataRepository;

  final ProfileController profileController = Get.find();
  final SubscriptionController subscriptionController = Get.find();
  final GymController gymController = Get.find();




  final count = 0.obs;
  @override
  void onInit() async{
    initializeData();
    profileController.refreshValue.value = true;
    await Future.wait([
      subscriptionController.getSubscriptionList(),
      gymController.getGymList(),
      profileController.getUserDetails(),
      profileController.getCustomerDetails(),
      profileController.getSubscriptionDetails(),
      profileController.getCheckInHistory(),
    ]);
    profileController.updateUserData();
    profileController.refreshValue.value = false;
    super.onInit();
  }

  initializeData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserRepository userRepository = UserRepository(prefs: sharedPreferences);
    userDataRepository = SessionRepository.instance;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
