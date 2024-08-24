import 'dart:convert';

import 'package:project2/models/exam_model.dart';
import 'package:project2/models/marking_scheme_model.dart';

import '../../main.dart';

class MarkingSchemeCreationService {
  //

  Future<MarkingSchemeModel?> addMarkingScheme(
    ExamModel exam,
    MarkingSchemeModel markingScheme,
  ) async {
    Map<String, dynamic> body = markingScheme.toJson();
    body.addAll({"exam_id": exam.id.toString()});

    print(jsonEncode(body));
    String? json = await api.postRequest("api/questionsExamForms/", body, auth: true);
    if (json != null) return MarkingSchemeModel.fromJson(jsonDecode(json));
    return null;
  }
}
