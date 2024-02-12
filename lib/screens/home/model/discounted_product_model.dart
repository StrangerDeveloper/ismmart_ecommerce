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
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    totalReviews = json['totalReviews'];
    rating = json['rating'];
    quantity = json['quantity'];
    inStock = json['inStock'];
    price = json['price'];
    discount = json['discount'] != null
        ? new Discount.fromJson(json['discount'])
        : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    data['totalReviews'] = this.totalReviews;
    data['rating'] = this.rating;
    data['quantity'] = this.quantity;
    data['inStock'] = this.inStock;
    data['price'] = this.price;
    if (this.discount != null) {
      data['discount'] = this.discount!.toJson();
    }
    data['image'] = this.image;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['percentage'] = this.percentage;
    return data;
  }
}
