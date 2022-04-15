import 'dart:convert';
import 'dart:io';

import 'package:gym_app/app/config/constants.dart';
import 'package:gym_app/app/data/network/network_helper.dart';
import 'package:gym_app/main.dart';


class AuthRepository {
  static Future<bool> verifyLogin(String email, String password) async {
    const url = '$baseUrl/accounts/auth/customer/jwt/create/';
    final body = jsonEncode({'email': email, 'password': password});
    try {
      final response = await NetworkHelper().postRequest(url, data: body);
      if (response.statusCode == 200) {
        final token = response.data['access'];
        String key = "access_token";
        String loginType = "login_type";
        await storage.write(key: key, value: token);
        await storage.write(key: loginType, value: "customer");
        return true;
      } else if (response.statusCode == 401) {
        return Future.error(
            'Invalid credentials. Please check your credentials.');
      } else {
        return Future.error(response.data['detail']);
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<bool> verifyGymLogin(String email, String password) async {
    const url = '$baseUrl/accounts/auth/gym/jwt/create/';
    final body = jsonEncode({'email': email, 'password': password});
    try {
      final response = await NetworkHelper().postRequest(url, data: body);
      if (response.statusCode == 200) {
        final token = response.data['access'];
        String key = "access_token";
        String loginType = "login_type";
        await storage.write(key: key, value: token);
        await storage.write(key: loginType, value: "gym");
        return true;
      } else if (response.statusCode == 401) {
        return Future.error(
            'Invalid credentials. Please check your credentials.');
      } else if (response.statusCode == 400) {
        return Future.error('Only Gym is Allowed to Login Here');
      } else {
        return Future.error(response.data['detail']);
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<bool> resetPassword(String email) async {
    const url = '$baseUrl/accounts/forget-password/';
    final body = jsonEncode({'email': email});
    try {
      final response = await NetworkHelper().postRequest(url, data: body);
      print('Response is $response');
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        return Future.error(
            'Invalid request. Please contact support.');
      } else if (response.statusCode == 400) {
        return Future.error('Please enter registered email');
      } else {
        return Future.error('Invalid');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<bool> changePassword(String password, String confirmPassword, String otp) async {
    const url = '$baseUrl/accounts/reset-password-form/';
    final body = jsonEncode({
      "otp": otp,
      "password": password,
      "confirm_password": confirmPassword
    });
    try {
      final response = await NetworkHelper().postRequest(url, data: body);
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        return Future.error(
            'Invalid request. Please contact support.');
      } else if (response.statusCode == 400) {
        return Future.error('Please enter correct Otp.');
      } else {
        return Future.error('Invalid');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<bool> registerUser(String username, String email,
      String password, String address, String phone) async {
    const url = '$baseUrl/accounts/register-customer/';
    final body = jsonEncode({
      'name': username,
      'email': email,
      'address': address,
      'phone': phone,
      'password': password,
    });

    try {
      final response = await NetworkHelper().postRequest(url, data: body);
      if (response.statusCode == 201) {
        return true;
      } else if(response.statusCode == 400){
        return Future.error("This email has already been registered.");
      }else{
        return Future.error("Registration failed. Please try again");
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
