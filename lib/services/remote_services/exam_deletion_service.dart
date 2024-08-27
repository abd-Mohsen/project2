import 'package:project2/models/exam_model.dart';
import '../../main.dart';

class ExamDeletionService {
  Future<bool> deleteExam(ExamModel exam) async {
    return await api.deleteRequest("api/exams/${exam.id}/", auth: true);
  }
}
