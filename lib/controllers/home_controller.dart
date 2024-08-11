import 'package:get/get.dart';
import 'package:project2/models/exam_model.dart';
import 'package:project2/services/local_services/exam_selection_service.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    getExams();
    _selectedExamID = _examSelectionService.loadSelectedExamId();
    super.onInit();
  }

  @override
  void dispose() {
    //
    super.dispose();
  }

  final ExamSelectionService _examSelectionService = ExamSelectionService();
  final List<ExamModel> exams = [];

  int _selectedExamID = -1;
  int get selectedExamID => _selectedExamID;

  void selectExam(ExamModel exam) {
    _examSelectionService.saveSelectedExamId(exam.id);
    _selectedExamID = exam.id;
    update();
  }

  void getExams() async {
    exams.addAll(
      [
        ExamModel(
          id: 1,
          title: "multimedia 2023-2024",
          markingSchemes: [
            MarkingSchemeModel(
              id: 1,
              title: "A",
              size: 3,
              questions: [
                QuestionModel(number: 1, answer: "a"),
                QuestionModel(number: 2, answer: "d"),
                QuestionModel(number: 3, answer: "a"),
              ],
            ),
            MarkingSchemeModel(
              id: 2,
              title: "B",
              size: 3,
              questions: [
                QuestionModel(number: 1, answer: "a"),
                QuestionModel(number: 2, answer: "d"),
                QuestionModel(number: 3, answer: "a"),
              ],
            ),
          ],
        ),
        ExamModel(
          id: 2,
          title: "KBS 2022-2023",
          markingSchemes: [
            MarkingSchemeModel(
              id: 1,
              title: "A",
              size: 4,
              questions: [
                QuestionModel(number: 1, answer: "a"),
                QuestionModel(number: 2, answer: "d"),
                QuestionModel(number: 3, answer: "a"),
                QuestionModel(number: 4, answer: "d"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
