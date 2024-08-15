import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project2/models/exam_model.dart';

class ExamController extends GetxController {
  late ExamModel exam;
  ExamController(this.exam);
  TextEditingController title = TextEditingController();
  List<QuestionModel> questions = [];

  void initCreateScheme(int qNum) {
    if (questions.isNotEmpty) return;
    for (int i = 1; i <= qNum; i++) {
      questions.add(QuestionModel(number: i, answer: "z"));
    }
  }

  void setChoice(QuestionModel question, String choice) {
    question.answer = choice;
    update();
  }

  Future<void> addMarkingScheme() async {
    MarkingSchemeModel newScheme = MarkingSchemeModel(id: -1, title: title.text, questions: questions);
    //todo: make a request, pass title and questions, with loading, and prevent pressing if loading
    //todo: create a form and validate it
    exam.markingSchemes.add(newScheme);
    update();
  }
}
