import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:gym_app/app/data/model/customer.dart';
import 'package:gym_app/app/data/model/gym_profile.dart';
import 'package:gym_app/app/data/model/subscription.dart';
import 'package:gym_app/app/data/model/user.dart';

class SessionRepository {
  SessionRepository._privateConstructor();

  static final SessionRepository _instance =
      SessionRepository._privateConstructor();

  static SessionRepository get instance => _instance;

  Customer _customer;
  User _user;
  String _subscription;
  bool _customerLogin;
  GymProfile _gymProfile;

  Customer get customer => _customer;

  GymProfile get gymProfile => _gymProfile;

  String get subscription => _subscription;

  User get user => _user;

  bool get customerLogin => _customerLogin;

  void setUser(User user) {
    _user = user;
  }

  void setGymProfile(GymProfile profile){
    _gymProfile = profile;
  }

  void setCustomerLogin(bool customerLogin) {
    _customerLogin = customerLogin;
  }

  void setSubscribed(String subscription) {
    _subscription = subscription;
  }

  void setCustomer(Customer customer) {
    _customer = customer;
  }

}
