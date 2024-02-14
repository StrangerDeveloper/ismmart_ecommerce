class SubCategoryModel {
  String? sId;
  String? name;
  List<String>? media;

  SubCategoryModel({this.sId, this.name, this.media});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    media = json['media'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['media'] = this.media;
    return data;
  }
}
