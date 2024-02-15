class CollectionModel {
  String? sId;
  String? name;
  List<String>? media;
  List<Children>? children;

  CollectionModel({this.sId, this.name, this.media, this.children});

  CollectionModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    media = json['media'].cast<String>();
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['media'] = media;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? sId;
  String? name;
  List<String>? media;
  String? parent;

  Children({this.sId, this.name, this.media, this.parent});

  Children.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    media = json['media'].cast<String>();
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['media'] = media;
    data['parent'] = parent;
    return data;
  }
}
