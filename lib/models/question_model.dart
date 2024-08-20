class QuestionModel {
  final int id;
  final int number;
  String answer;

  QuestionModel({
    required this.id,
    required this.number,
    required this.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json["id"],
        number: json["question_id"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "answer": answer,
      };
}
