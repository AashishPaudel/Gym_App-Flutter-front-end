class Subscription {
  Subscription({
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

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
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
