import 'dart:io';

class ProfileUpdateRequest {
  String name;
  File image;
  String address;

  ProfileUpdateRequest({this.name, this.address, this.image});
}

class ProfileGymRequest {
  String name;
  File image;
  String description;

  ProfileGymRequest({this.name, this.description, this.image});
}