import 'package:gym_app/main.dart';

class SecureStorage{
  static Future<Map<String, String>> returnHeaderToken() async{
    return {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Authorization": "JWT ${await storage.read(key: "access_token")}"
    };
  }

  static Future<Map<String, String>> returnHeaderMultipartToken() async{
    return {
      "Content-Type": "multipart/form-data",
      "Accept": "application/json",
      "Authorization": "JWT ${await storage.read(key: "access_token")}"
    };
  }

}