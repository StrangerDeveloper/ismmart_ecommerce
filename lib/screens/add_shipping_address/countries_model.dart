class CountriesModel {
  String? sId;
  String? name;
  num? latitude;
  num? longitude;
  String? code;

  CountriesModel(
      {this.sId, this.name, this.latitude, this.longitude, this.code});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['code'] = code;
    return data;
  }
}
