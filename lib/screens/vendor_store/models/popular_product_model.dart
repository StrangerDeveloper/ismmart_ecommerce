class PopularProductModel {
  String? sId;
  String? name;
  String? media;

  PopularProductModel({this.sId, this.name, this.media});

  PopularProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    media = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = media;
    return data;
  }
}