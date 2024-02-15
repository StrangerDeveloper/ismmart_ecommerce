class FaqModel {
  int? id;
  String? questions;
  String? answer;
  bool? delete;
  String? createdAt;
  String? updatedAt;

  FaqModel(
      {this.id,
      this.questions,
      this.answer,
      this.delete,
      this.createdAt,
      this.updatedAt});

  FaqModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    questions = json['questions'];
    answer = json['answer'];
    delete = json['delete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['questions'] = questions;
    data['answer'] = answer;
    data['delete'] = delete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
