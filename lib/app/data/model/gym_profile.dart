class GymProfile {
  GymProfile({
    this.id,
    this.addressDetail,
    this.companyName,
    this.description,
    this.image,
    this.qrcode,
    this.totalEarningCurrency,
    this.totalEarning,
    this.user,
    this.location,
  });

  int id;
  AddressDetail addressDetail;
  String companyName;
  String description;
  String image;
  String qrcode;
  String totalEarningCurrency;
  String totalEarning;
  int user;
  int location;

  factory GymProfile.fromJson(Map<String, dynamic> json) => GymProfile(
    id: json["id"] == null ? null : json["id"],
    addressDetail: json["address_detail"] == null ? null : AddressDetail.fromJson(json["address_detail"]),
    companyName: json["company_name"] == null ? null : json["company_name"],
    description: json["description"] == null ? null : json["description"],
    image: json["image"] == null ? null : json["image"],
    qrcode: json["qrcode"] == null ? null : json["qrcode"],
    totalEarningCurrency: json["total_earning_currency"] == null ? null : json["total_earning_currency"],
    totalEarning: json["total_earning"] == null ? null : json["total_earning"],
    user: json["user"] == null ? null : json["user"],
    location: json["location"] == null ? null : json["location"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "address_detail": addressDetail == null ? null : addressDetail.toJson(),
    "company_name": companyName == null ? null : companyName,
    "description": description == null ? null : description,
    "image": image == null ? null : image,
    "qrcode": qrcode == null ? null : qrcode,
    "total_earning_currency": totalEarningCurrency == null ? null : totalEarningCurrency,
    "total_earning": totalEarning == null ? null : totalEarning,
    "user": user == null ? null : user,
    "location": location == null ? null : location,
  };
}

class AddressDetail {
  AddressDetail({
    this.id,
    this.address,
    this.district,
    this.zone,
    this.municipality,
    this.street,
    this.province,
    this.localBodyName,
    this.locality,
    this.latitude,
    this.longitude,
  });

  int id;
  String address;
  String district;
  String zone;
  String municipality;
  String street;
  String province;
  String localBodyName;
  String locality;
  double latitude;
  double longitude;

  factory AddressDetail.fromJson(Map<String, dynamic> json) => AddressDetail(
    id: json["id"] == null ? null : json["id"],
    address: json["address"] == null ? null : json["address"],
    district: json["district"] == null ? null : json["district"],
    zone: json["zone"] == null ? null : json["zone"],
    municipality: json["municipality"] == null ? null : json["municipality"],
    street: json["street"] == null ? null : json["street"],
    province: json["province"] == null ? null : json["province"],
    localBodyName: json["local_body_name"] == null ? null : json["local_body_name"],
    locality: json["locality"] == null ? null : json["locality"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "address": address == null ? null : address,
    "district": district == null ? null : district,
    "zone": zone == null ? null : zone,
    "municipality": municipality == null ? null : municipality,
    "street": street == null ? null : street,
    "province": province == null ? null : province,
    "local_body_name": localBodyName == null ? null : localBodyName,
    "locality": locality == null ? null : locality,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
  };
}
