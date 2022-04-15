// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.email,
    this.name,
    this.address,
    this.gender,
    this.phone,
    this.image,
  });

  int id;
  String email;
  String name;
  String address;
  String gender;
  String phone;
  String image;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    email: json["email"] == null ? null : json["email"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    gender: json["gender"] == null ? null : json["gender"],
    phone: json["phone"] == null ? null : json["phone"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "email": email == null ? null : email,
    "name": name == null ? null : name,
    "address": address == null ? null : address,
    "gender": gender == null ? null : gender,
    "phone": phone == null ? null : phone,
    "image": image == null ? null : image,
  };
}
