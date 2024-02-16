class ShippingAdressModel {
  String? sId;
  String? vendor;
  String? name;
  String? status;
  String? address;
  bool? main;
  String? province;
  String? type;
  City? city;
  City? country;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ShippingAdressModel(
      {this.sId,
      this.vendor,
      this.name,
      this.status,
      this.address,
      this.main,
      this.province,
      this.type,
      this.city,
      this.country,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ShippingAdressModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vendor = json['vendor'];
    name = json['name'];
    status = json['status'];
    address = json['address'];
    main = json['main'];
    province = json['province'];
    type = json['type'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    country =
        json['country'] != null ? new City.fromJson(json['country']) : null;
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['vendor'] = this.vendor;
    data['name'] = this.name;
    data['status'] = this.status;
    data['address'] = this.address;
    data['main'] = this.main;
    data['province'] = this.province;
    data['type'] = this.type;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class City {
  String? sId;
  String? name;

  City({this.sId, this.name});

  City.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
