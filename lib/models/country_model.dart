class CountryModel {
  String? sId;
  int? id;
  String? name;
  double? latitude;
  double? longitude;
  String? code;
  String? updatedAt;
  bool? deleted;

  CountryModel(
      {this.sId,
        this.id,
        this.name,
        this.latitude,
        this.longitude,
        this.code,
        this.updatedAt,
        this.deleted});

  CountryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    name = json['name'];
    latitude = double.tryParse(json['latitude'].toString());
    longitude = double.tryParse(json['longitude'].toString());
    code = json['code'];
    updatedAt = json['updatedAt'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['code'] = code;
    data['updatedAt'] = updatedAt;
    data['deleted'] = deleted;
    return data;
  }
}