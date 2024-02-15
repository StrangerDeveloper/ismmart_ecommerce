class NewsModel {
  String? sId;
  String? name;
  String? type;
  String? description;

  NewsModel({this.sId, this.type, this.name, this.description});

  NewsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['type'] = type;
    data['description'] = description;
    return data;
  }
}
