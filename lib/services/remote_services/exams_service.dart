import 'package:project2/models/exam_model.dart';

import '../../main.dart';

class ExamsService {
  //
  Future<List<ExamModel>?> getAllExams() async {
    String? json = await api.getRequest("api/exams/", auth: true);
    if (json == null) return null;
    return examModelFromJson(json);
  }
}
