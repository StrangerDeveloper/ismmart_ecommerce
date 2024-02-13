class NewsModel {
  String? sId;
  String? name;
  String? description;

  NewsModel({this.sId, this.name, this.description});

  NewsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
