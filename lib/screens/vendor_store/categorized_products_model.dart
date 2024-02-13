class CategorizedProductsModel {
  String? sId;
  String? name;
  List<Products>? products;
  List<String>? media;

  CategorizedProductsModel({this.sId, this.name, this.products, this.media});

  CategorizedProductsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    media = json['media'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['media'] = media;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {

  String? id;
  String? name;
  Discount? discount;
  int? reviews;
  double? rating;
  String? image;
  int? price;

  Products({this.name, this.discount, this.reviews, this.rating, this.image, this.id, this.price});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    discount = json['discount'] != null ? Discount.fromJson(json['discount']) : null;
    reviews = json['totalReviews'];
    rating = json['rating'];
    image = json['image'];
    price = json['price'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['price'] = price;
    data['name'] = name;
    if (discount != null) {
      data['discount'] = discount!.toJson();
    }
    data['reviews'] = reviews;
    data['rating'] = rating;
    data['image'] = image;
    return data;
  }
}

class Discount {
  String? sId;
  String? name;
  int? percentage;

  Discount({this.sId, this.name, this.percentage});

  Discount.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['percentage'] = percentage;
    return data;
  }
}