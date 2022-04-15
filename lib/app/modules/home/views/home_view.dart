import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gym_app/app/config/theme_colors.dart';
import 'package:gym_app/app/modules/check_in/views/check_in_view.dart';
import 'package:gym_app/app/modules/gym/controllers/gym_controller.dart';
import 'package:gym_app/app/modules/gym/views/gym_view.dart';
import 'package:gym_app/app/modules/profile/views/profile_view.dart';
import 'package:gym_app/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:gym_app/app/modules/subscription/views/subscription_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.find();
  final GymController gymController = Get.find();
  final SubscriptionController subscriptionController = Get.find();

  int selectedIndex = 0;



  final List<Widget> pages = [
    SubscriptionView(),
    const GymView(),
    // GymMapView(),
    const CheckInView(),
    ProfileView(),
  ];

  void changeNavBarIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
            fontFamily: 'Poppins',
            color: primaryColor,
            fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500),
        selectedIconTheme: const IconThemeData(
          color: primaryColor
        ),

        unselectedItemColor: const Color(0xff667C8A),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Subscription',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_rounded),
            label: 'Gym',
            backgroundColor: Colors.white,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Check-In',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: 'Profile',
            backgroundColor: Colors.white,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.perm_identity_rounded),
          //   label: 'Profile',
          //   backgroundColor: Colors.white,
          // ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: primaryColor,
        onTap: changeNavBarIndex,
      ),
      body: Center(
        child: pages.elementAt(selectedIndex),
      ),
    );
  }
}
