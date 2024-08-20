import '../../main.dart';

class ExamCreationService {
  //

  Future<bool> addExam(
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
    if (await api.postRequest("api/exams/", body, auth: true) != null) return true;
    return false;
  }
}
