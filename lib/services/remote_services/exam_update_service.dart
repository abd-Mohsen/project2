import 'dart:convert';

import 'package:project2/models/exam_model.dart';

import '../../main.dart';

class ExamUpdateService {
  Future<ExamModel?> editExam(
    int id,
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
    String? json = await api.putRequest("api/exams/$id/", body, auth: true);
    if (json != null) return ExamModel.fromJson(jsonDecode(json));
    return null;
  }
}
