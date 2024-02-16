class FilterModel {
  Price? price;

  FilterModel({this.price});

  FilterModel.fromJson(Map<String, dynamic> json) {
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (price != null) {
      data['price'] = price!.toJson();
    }
    return data;
  }
}

class Price {
  num? min;
  num? max;

  Price({this.min, this.max});

  Price.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min'] = min;
    data['max'] = max;
    return data;
  }
}
