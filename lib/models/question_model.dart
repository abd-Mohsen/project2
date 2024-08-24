class QuestionModel {
  final int? id;
  final int number;
  String answer;

  QuestionModel({
    this.id,
    required this.number,
    required this.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json["id"],
        number: json["question_id"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "question_id": number,
        "answer": answer,
      };
}
