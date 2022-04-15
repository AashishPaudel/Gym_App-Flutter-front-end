class Gym {
  Gym({
    this.id,
    this.companyName,
    this.description,
    this.image,
    this.qrcode,
    this.location,
    this.locationMap,
  });

  int id;
  String companyName;
  String description;
  String image;
  String qrcode;
  Location location;
  String locationMap;

  factory Gym.fromJson(Map<String, dynamic> json) => Gym(
    id: json["id"] == null ? null : json["id"],
    companyName: json["company_name"] == null ? null : json["company_name"],
    description: json["description"] == null ? null : json["description"],
    image: json["image"] == null ? null : json["image"],
    qrcode: json["qrcode"] == null ? null : json["qrcode"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    locationMap: json["location_map"] == null ? null : json["location_map"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "company_name": companyName == null ? null : companyName,
    "description": description == null ? null : description,
    "image": image == null ? null : image,
    "qrcode": qrcode == null ? null : qrcode,
    "location": location == null ? null : location.toJson(),
    "location_map": locationMap == null ? null : locationMap,
  };
}

class Location {
  Location({
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

  factory Location.fromJson(Map<String, dynamic> json) => Location(
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
