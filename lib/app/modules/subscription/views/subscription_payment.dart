import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:gym_app/app/modules/subscription/controllers/subscription_controller.dart';

class SubscriptionPayment extends GetView<SubscriptionController> {
  static String id = '/payment';


  SubscriptionPayment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 4,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 8, bottom: 8, right: 6),
                                child: const Center(
                                    child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 18,
                                )),
                              )),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                    const SizedBox(height: 29),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: Get.height * 0.18,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff5C2E91)),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(3.0, 3.0),
                                            blurRadius: 2.0,
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 0.2,
                                          ),
                                        ]),
                                    child: Image.asset(
                                      'assets/khalti.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 29),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  height: Get.height * 0.18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Color(0xff60BB47)),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(3.0, 3.0),
                                          blurRadius: 2.0,
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 0.2,
                                        ),
                                      ]),
                                  child: Image.asset(
                                    'assets/esewa-logo.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 29),
                      ],
                    ),
                    const Expanded(flex: 3, child: SizedBox()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
