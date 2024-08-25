import 'dart:convert';

import 'package:project2/models/exam_model.dart';

import '../../main.dart';

class ExamService {
  //
  Future<ExamModel?> getExam(int id) async {
    String? json = await api.getRequest("api/exams/$id/", auth: true);
    if (json == null) return null;
    return ExamModel.fromJson(jsonDecode(json));
  }
}
