import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/models/exam_model.dart';
import 'package:project2/services/remote_services/marking_scheme_creation_service.dart';
import 'package:project2/services/remote_services/marking_scheme_deletion_service.dart';
import 'package:project2/services/remote_services/marking_scheme_update_service.dart';
import '../models/marking_scheme_model.dart';
import '../models/question_model.dart';

class ExamController extends GetxController {
  late ExamModel exam; //get exam from id (request) and find a way to map it to the og list
  ExamController({
    required this.exam,
    required this.markingSchemeCreationService,
    required this.markingSchemeDeletionService,
    required this.markingSchemeUpdateService,
  });

  late MarkingSchemeCreationService markingSchemeCreationService;
  late MarkingSchemeDeletionService markingSchemeDeletionService;
  late MarkingSchemeUpdateService markingSchemeUpdateService;

  TextEditingController title = TextEditingController();
  List<QuestionModel> questions = []; // for add
  List<QuestionModel> questions2 = []; //for edit

  void initCreateScheme(int qNum) {
    title.text = "";
    if (questions.isNotEmpty) return;
    for (int i = 1; i <= qNum; i++) {
      questions.add(QuestionModel(number: i, answer: "z"));
    }
  }

  void initEditScheme(MarkingSchemeModel markingScheme) {
    questions2.clear();
    title.text = markingScheme.title;
    for (int i = 0; i < markingScheme.questions.length; i++) {
      questions2.add(
        QuestionModel(
          id: markingScheme.questions[i].id,
          number: i + 1,
          answer: markingScheme.questions[i].answer,
        ),
      );
    }
  }

  void resetAndCloseForm() {
    questions.clear();
    initCreateScheme(exam.questionsCount);
    isButtonPressed = false;
    Get.back();
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
    for (QuestionModel question in questions) {
      if (question.answer == "z") {
        Get.snackbar(
          "error".tr,
          "please mark all questions first".tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    }
    //
    setLoading(true);
    MarkingSchemeModel schemeTemp = MarkingSchemeModel(title: title.text, questions: List.from(questions));
    MarkingSchemeModel? createdScheme = await markingSchemeCreationService.addMarkingScheme(exam, schemeTemp);
    if (createdScheme == null) {
      print("failed to add m.scheme");
      setLoading(false);
      return;
    }
    exam.markingSchemes.add(createdScheme);
    setLoading(false);
    resetAndCloseForm();
  }

  Future<void> deleteMarkingScheme(MarkingSchemeModel markingScheme) async {
    if (await markingSchemeDeletionService.deleteMarkingScheme(markingScheme)) {
      exam.markingSchemes.remove(markingScheme);
      update();
    } else {
      print("failed to delete m.scheme");
    }
  }

  Future<void> editMarkingScheme(MarkingSchemeModel markingScheme) async {
    if (loading) return;
    isButtonPressed = true;
    if (!formKey.currentState!.validate()) return;
    //
    setLoading(true);
    markingScheme.title = title.text;
    markingScheme.questions = List.from(questions2);
    MarkingSchemeModel? editedScheme = await markingSchemeUpdateService.editMarkingScheme(exam, markingScheme);
    if (editedScheme == null) {
      print("failed to edit m.scheme");
      setLoading(false);
      return;
    }
    //markingScheme = editedScheme;
    setLoading(false);
    questions2.clear();
    Get.back();
  }
}

// {
// "exam_id": 3,
// "form_name": "Ass",
// "questions": [
//  {
//    "question_id": 1,
//    "answer": "a"
//  },
//  {
//    "question_id": 2,
//    "answer": "d"
//  }
//  ]
// }
