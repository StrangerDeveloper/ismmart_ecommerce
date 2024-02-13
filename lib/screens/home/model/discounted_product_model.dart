class DiscountedProductModel {
  String? name;
  String? sId;
  Store? store;
  int? totalReviews;
  num? rating;
  int? quantity;
  bool? inStock;
  num? price;
  Discount? discount;
  String? image;

  DiscountedProductModel(
      {this.sId,
        this.name,
        this.store,
        this.totalReviews,
        this.rating,
        this.quantity,
        this.inStock,
        this.price,
        this.discount,
        this.image});

  DiscountedProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sId = json['_id'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    totalReviews = json['totalReviews'];
    rating = json['rating'];
    quantity = json['quantity'];
    inStock = json['inStock'];
    price = json['price'];
    discount = json['discount'] != null
        ? Discount.fromJson(json['discount'])
        : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    data['totalReviews'] = totalReviews;
    data['rating'] = rating;
    data['quantity'] = quantity;
    data['inStock'] = inStock;
    data['price'] = price;
    if (discount != null) {
      data['discount'] = discount!.toJson();
    }
    data['image'] = image;
    return data;
  }
}

class Store {
  String? name;

  Store({this.name});

  Store.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Discount {
  int? percentage;

  Discount({this.percentage});

  Discount.fromJson(Map<String, dynamic> json) {
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['percentage'] = percentage;
    return data;
  }
}
