class Customer {
  Customer({
    this.id,
    this.subscriptionDetails,
    this.description,
    this.image,
    this.totalCheckIns,
    this.remainingCheckIns,
    this.user,
    this.subscription,
  });

  int id;
  dynamic subscriptionDetails;
  dynamic description;
  dynamic image;
  int totalCheckIns;
  int remainingCheckIns;
  int user;
  dynamic subscription;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"] ?? null,
        subscriptionDetails: json["subscription_details"],
        description: json["description"],
        image: json["image"],
        totalCheckIns:
            json["total_check_ins"] == null ? null : json["total_check_ins"],
        remainingCheckIns: json["remaining_check_ins"] == null
            ? null
            : json["remaining_check_ins"],
        user: json["user"] == null ? null : json["user"],
        subscription: json["subscription"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "subscription_details": subscriptionDetails,
        "description": description,
        "image": image,
        "total_check_ins": totalCheckIns == null ? null : totalCheckIns,
        "remaining_check_ins":
            remainingCheckIns == null ? null : remainingCheckIns,
        "user": user == null ? null : user,
        "subscription": subscription,
      };
}
