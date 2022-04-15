import 'dart:convert';
import 'dart:io';

import 'package:gym_app/app/config/constants.dart';
import 'package:gym_app/app/data/model/gym.dart';
import 'package:gym_app/app/data/model/subscription.dart';
import 'package:gym_app/app/data/network/network_helper.dart';
import 'package:gym_app/app/data/repositories/secure_storage.dart';
import 'package:gym_app/app/data/repositories/session_repository.dart';

class DashboardRequest {

  static Future<bool> serverVerification(String token, int price) async {
    const url = '$baseUrl/payment/confirm-payment/';
    final body = jsonEncode({'token': token, 'amount': price});
    try {
      final response = await NetworkHelper()
          .postRequest(url, data: body, contentType: await SecureStorage.returnHeaderToken());
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        return Future.error('Server verification failed.');
      } else {
        return Future.error(response.data['message']);
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<bool> checkIn(String url) async {
    var parts = url.split('8000');
    var afterPort = parts[1].trim();
    String newUrl = '$baseUrl$afterPort';
    try {
      final response = await NetworkHelper()
          .postRequest(newUrl, contentType: await SecureStorage.returnHeaderToken());
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        return Future.error('You do not have any subscriptions.');
      } else {
        return Future.error(response.data['message']);
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<bool> buySubscription(String subscriptionId) async {
    final url = '$baseUrl/customers/subscribe/${SessionRepository.instance.customer.id}/';
    final body = jsonEncode({"subscription": subscriptionId});
    try {
      final response = await NetworkHelper()
          .patchRequest(url, data: body, contentType: await SecureStorage.returnHeaderToken());
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        return Future.error('Could not complete transaction.');
      } else {
        return Future.error("Server failed. Please try again.");
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Subscription>> getSubscription() async {
    String url = '$baseUrl/subscriptions/subscription/';
    try {
      final response =
          await NetworkHelper().getRequest(url, contentType: await SecureStorage.returnHeaderToken());
      if (response.statusCode == 200) {
        List<Subscription> subscriptionList = (response.data as List)
            .map((i) => Subscription.fromJson(i))
            .toList();
        return subscriptionList;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        return Future.error(response.statusMessage);
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Gym>> getGym() async {
    String url = '$baseUrl/gym/all-gyms/';
    try {
      final response =
          await NetworkHelper().getRequest(url, contentType: await SecureStorage.returnHeaderToken());
      print(response);
      if (response.statusCode == 200) {
        List<Gym> gymList =
            (response.data as List).map((i) => Gym.fromJson(i)).toList();
        return gymList;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        return Future.error(response.statusMessage);
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
