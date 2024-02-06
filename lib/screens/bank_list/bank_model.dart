class BankModel {
  String? sId;
  String? user;
  String? name;
  String? title;
  String? iban;
  String? accountNumber;

  BankModel(
      {this.sId,
        this.user,
        this.name,
        this.title,
        this.iban,
        this.accountNumber});

  BankModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    name = json['name'];
    title = json['title'];
    iban = json['iban'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    data['name'] = name;
    data['title'] = title;
    data['iban'] = iban;
    data['accountNumber'] = accountNumber;
    return data;
  }
}
