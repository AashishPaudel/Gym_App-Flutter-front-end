class Subscribed {
  Subscribed({
    this.id,
    this.gym,
    this.customer,
    this.customerName,
    this.gymName,
    this.checkInAt,
  });

  int id;
  Gym gym;
  Customer customer;
  String customerName;
  String gymName;
  DateTime checkInAt;

  factory Subscribed.fromJson(Map<String, dynamic> json) => Subscribed(
    id: json["id"] == null ? null : json["id"],
    gym: json["gym"] == null ? null : Gym.fromJson(json["gym"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    customerName: json["customer_name"] == null ? null : json["customer_name"],
    gymName: json["gym_name"] == null ? null : json["gym_name"],
    checkInAt: json["check_in_at"] == null ? null : DateTime.parse(json["check_in_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "gym": gym == null ? null : gym.toJson(),
    "customer": customer == null ? null : customer.toJson(),
    "customer_name": customerName == null ? null : customerName,
    "gym_name": gymName == null ? null : gymName,
    "check_in_at": checkInAt == null ? null : checkInAt.toIso8601String(),
  };
}

class Customer {
  Customer({
    this.id,
    this.subscriptionDetails,
    this.description,
    this.totalCheckIns,
    this.remainingCheckIns,
    this.user,
    this.subscription,
  });

  int id;
  SubscriptionDetails subscriptionDetails;
  dynamic description;
  int totalCheckIns;
  int remainingCheckIns;
  int user;
  int subscription;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] == null ? null : json["id"],
    subscriptionDetails: json["subscription_details"] == null ? null : SubscriptionDetails.fromJson(json["subscription_details"]),
    description: json["description"],
    totalCheckIns: json["total_check_ins"] == null ? null : json["total_check_ins"],
    remainingCheckIns: json["remaining_check_ins"] == null ? null : json["remaining_check_ins"],
    user: json["user"] == null ? null : json["user"],
    subscription: json["subscription"] == null ? null : json["subscription"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "subscription_details": subscriptionDetails == null ? null : subscriptionDetails.toJson(),
    "description": description,
    "total_check_ins": totalCheckIns == null ? null : totalCheckIns,
    "remaining_check_ins": remainingCheckIns == null ? null : remainingCheckIns,
    "user": user == null ? null : user,
    "subscription": subscription == null ? null : subscription,
  };
}

class SubscriptionDetails {
  SubscriptionDetails({
    this.id,
    this.name,
    this.description,
    this.validFor,
    this.image,
    this.priceCurrency,
    this.price,
    this.perDayPriceCurrency,
    this.perDayPrice,
  });

  int id;
  String name;
  String description;
  int validFor;
  dynamic image;
  String priceCurrency;
  String price;
  String perDayPriceCurrency;
  String perDayPrice;

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) => SubscriptionDetails(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    validFor: json["valid_for"] == null ? null : json["valid_for"],
    image: json["image"],
    priceCurrency: json["price_currency"] == null ? null : json["price_currency"],
    price: json["price"] == null ? null : json["price"],
    perDayPriceCurrency: json["per_day_price_currency"] == null ? null : json["per_day_price_currency"],
    perDayPrice: json["per_day_price"] == null ? null : json["per_day_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "valid_for": validFor == null ? null : validFor,
    "image": image,
    "price_currency": priceCurrency == null ? null : priceCurrency,
    "price": price == null ? null : price,
    "per_day_price_currency": perDayPriceCurrency == null ? null : perDayPriceCurrency,
    "per_day_price": perDayPrice == null ? null : perDayPrice,
  };
}

class Gym {
  Gym({
    this.id,
    this.addressDetail,
    this.companyName,
    this.description,
    this.qrcode,
    this.totalEarningCurrency,
    this.totalEarning,
    this.user,
    this.location,
  });

  int id;
  dynamic addressDetail;
  String companyName;
  String description;
  String qrcode;
  String totalEarningCurrency;
  String totalEarning;
  int user;
  dynamic location;

  factory Gym.fromJson(Map<String, dynamic> json) => Gym(
    id: json["id"] == null ? null : json["id"],
    addressDetail: json["address_detail"],
    companyName: json["company_name"] == null ? null : json["company_name"],
    description: json["description"] == null ? null : json["description"],
    qrcode: json["qrcode"] == null ? null : json["qrcode"],
    totalEarningCurrency: json["total_earning_currency"] == null ? null : json["total_earning_currency"],
    totalEarning: json["total_earning"] == null ? null : json["total_earning"],
    user: json["user"] == null ? null : json["user"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "address_detail": addressDetail,
    "company_name": companyName == null ? null : companyName,
    "description": description == null ? null : description,
    "qrcode": qrcode == null ? null : qrcode,
    "total_earning_currency": totalEarningCurrency == null ? null : totalEarningCurrency,
    "total_earning": totalEarning == null ? null : totalEarning,
    "user": user == null ? null : user,
    "location": location,
  };
}
