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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}
