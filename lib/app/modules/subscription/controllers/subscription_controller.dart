import 'package:get/get.dart';
import 'package:gym_app/app/data/model/subscription.dart';
import 'package:gym_app/app/data/request/dashboard_request.dart';

class SubscriptionController extends GetxController {
  //TODO: Implement SubscriptionController

  final List months = ["One", "Six", "Twelve", "Eighteen"];
  final List days = ["30", "180", "365", "540"];
  final List price = ["1500", "9000", "18000", "25000"];

  String error = '';
  final subscriptionList = [].obs;

  final refreshValue = false.obs;
  final loading = false.obs;

  final selectedIndex = 0.obs;

  List<Subscription> subscriptionListModel;

  final selectedSubscription = Subscription().obs;

  setSelectedSubscription(Subscription subscription) =>
      selectedSubscription.value = subscription;

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

  Future<bool> requestVerification(String token, int amount) async {
    bool returnValue = false;
    await DashboardRequest.serverVerification(token, amount)
        .catchError((error) {
      this.error = error;
    }).then((value) {
      if (value is! bool) {
        returnValue = false;
        return;
      }
      if (value) {
        returnValue = true;
        return;
      } else {
        returnValue = false;
        return;
      }
    });
    return returnValue;
  }

  Future<bool> subscribe() async {
    bool returnValue = false;
    await DashboardRequest.buySubscription(
            subscriptionList[selectedIndex.value].id.toString())
        .catchError((error) {
      this.error = error;
    }).then((value) {
      if (value is! bool) {
        returnValue = false;
        return;
      }
      if (value) {
        returnValue = true;
        return;
      } else {
        returnValue = false;
        return;
      }
    });
    return returnValue;
  }

  Future<List<Subscription>> getSubscriptionList() async {
    refreshValue.value = true;
    await DashboardRequest.getSubscription().catchError((error) {
      this.error = error;
      refreshValue.value = false;
    }).then((value) {
      if (value == null) {
        return [];
      }
      if (value.isEmpty) {
        return [];
      }
      subscriptionList.value = value;
      subscriptionListModel = value;
      setSelectedSubscription(subscriptionList[0]);
    });
    refreshValue.value = false;
    return subscriptionListModel;
  }
}
