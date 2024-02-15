class UserProfileModel {
  String? sId;
  String? email;
  String? name;
  String? phone;
  String? gender;
  String? cnic;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? deleted;
  Role? role;
  String? reason;
  String? social;
  Store? store;
  String? image;

  UserProfileModel(
      {this.sId,
      this.email,
      this.name,
      this.phone,
      this.gender,
      this.cnic,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.deleted,
      this.role,
      this.reason,
      this.social,
      this.store,
      this.image});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    gender = json['gender'];
    cnic = json['cnic'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    deleted = json['deleted'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    reason = json['reason'];
    social = json['social'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['gender'] = gender;
    data['cnic'] = cnic;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['deleted'] = deleted;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    data['reason'] = reason;
    data['social'] = social;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    data['image'] = image;
    return data;
  }
}

class Role {
  String? sId;
  String? name;

  Role({this.sId, this.name});

  Role.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}

class Store {
  String? sId;
  String? vendor;
  String? slug;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? logo;
  List<Types>? types;
  String? name;

  Store(
      {this.sId,
      this.vendor,
      this.slug,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.logo,
      this.types,
      this.name});

  Store.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vendor = json['vendor'];
    slug = json['slug'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    logo = json['logo'];
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(Types.fromJson(v));
      });
    }
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['vendor'] = vendor;
    data['slug'] = slug;
    data['deleted'] = deleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['logo'] = logo;
    if (types != null) {
      data['types'] = types!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    return data;
  }
}

class Types {
  String? sId;
  String? name;

  Types({this.sId, this.name});

  Types.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}
