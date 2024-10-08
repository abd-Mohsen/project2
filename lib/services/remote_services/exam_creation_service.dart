import 'dart:convert';

import 'package:project2/models/exam_model.dart';

import '../../main.dart';

class ExamCreationService {
  //

  Future<ExamModel?> addExam(
    String title,
    String passMark,
    String completeMark,
    String qNum,
    int classID,
  ) async {
    Map<String, String> body = {
      "title": title,
      "pass_mark": passMark,
      "complete_mark": completeMark,
      "question_number": qNum,
      "classes_id": classID.toString()
    };
    String? json = await api.postRequest("api/exams/", body, auth: true);
    if (json != null) return ExamModel.fromJson(jsonDecode(json));
    return null;
  }
}
