class DiscountModel {
  String? sId;
  String? name;
  String? start;
  String? end;

  DiscountModel({this.sId, this.name, this.start, this.end});

  DiscountModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}
