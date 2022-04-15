import 'package:get/get.dart';
import 'package:gym_app/app/data/model/gym.dart';
import 'package:gym_app/app/data/request/dashboard_request.dart';

class GymController extends GetxController {
  //TODO: Implement GymController

  final List name = ["Fitness Corner", "Fitness Arena", "Sweat Arena", "Sweat Corner"];
  final List location = ["Balaju", "Tokha", "New Road", "Kakani"];
  final List phone = ["98********", "98********", "98********", "98********"];

  String error = '';
  final refreshValue = false.obs;
  final gymList = [].obs;

  final selectedIndex = 0.obs;

  List<Gym> gymListModel;

  final selectedGym = Gym().obs;

  setSelectedGym(Gym gym) =>
      selectedGym.value = gym;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<List<Gym>> getGymList() async {
    refreshValue.value = true;
    await DashboardRequest.getGym().catchError((error) {
      this.error = error;
      refreshValue.value = false;
    }).then((value) {
      if (value == null) {
        return [];
      }
      if (value.isEmpty) {
        return [];
      }
      gymList.value = value;
      gymListModel = value;
      setSelectedGym(gymList[0]);

    });
    refreshValue.value = false;
    return gymListModel;
  }
}
