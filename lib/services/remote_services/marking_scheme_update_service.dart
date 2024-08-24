import 'dart:convert';
import 'package:project2/models/exam_model.dart';
import 'package:project2/models/marking_scheme_model.dart';
import '../../main.dart';

class MarkingSchemeUpdateService {
  Future<MarkingSchemeModel?> editMarkingScheme(
    ExamModel exam,
    MarkingSchemeModel markingScheme,
  ) async {
    Map<String, dynamic> body = markingScheme.toJson();
    body.addAll({"exam_id": exam.id.toString()});
    body.addAll({"id": markingScheme.id.toString()});

    print(jsonEncode(body));
    String? json = await api.putRequest("api/questionsExamForms/${markingScheme.id}/", body, auth: true);
    if (json != null) return MarkingSchemeModel.fromJson(jsonDecode(json));
    return null;
  }
}
