import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project2/models/exam_model.dart';

import '../models/marking_scheme_model.dart';
import '../models/question_model.dart';

class ExamController extends GetxController {
  late ExamModel exam; //get exam from id (request) and find a way to map it to the og list
  ExamController(this.exam);

  TextEditingController title = TextEditingController();
  List<QuestionModel> questions = [];

  void initCreateScheme(int qNum) {
    if (questions.isNotEmpty) return;
    for (int i = 1; i <= qNum; i++) {
      questions.add(QuestionModel(id: i, number: i, answer: "z"));
    }
  }

  void setChoice(QuestionModel question, String choice) {
    question.answer = choice;
    update();
  }

  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool value) {
    _loading = value;
    update();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isButtonPressed = false;

  Future<void> addMarkingScheme() async {
    if (loading) return;
    isButtonPressed = true;
    if (!formKey.currentState!.validate()) return;
    setLoading(true);
    MarkingSchemeModel newScheme = MarkingSchemeModel(id: -1, title: title.text, questions: questions);
    //todo: make a request, pass title and questions
    //todo: make sure that all answers are selected in efficient way
    exam.markingSchemes.add(newScheme);
    setLoading(false);
  }
}
