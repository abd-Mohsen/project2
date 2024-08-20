import 'package:get/get.dart';
import 'package:project2/services/remote_services/exams_service.dart';

import '../models/exam_model.dart';
import '../services/local_services/exam_selection_service.dart';

class ExamsController extends GetxController {
  ExamsController({required this.examSelectionService, required this.examsService});
  @override
  void onInit() async {
    await getExams();
    _selectedExamID = examSelectionService.loadSelectedExamId();
    super.onInit();
  }

  late ExamSelectionService examSelectionService;
  late ExamsService examsService;

  final List<ExamModel> exams = [];
  int _selectedExamID = -1;
  int get selectedExamID => _selectedExamID;

  void selectExam(ExamModel exam) {
    examSelectionService.saveSelectedExamId(exam.id);
    _selectedExamID = exam.id;
    update();
  }

  Future getExams() async {
    List<ExamModel> newExams = await examsService.getAllExams() ?? [];
    exams.addAll(newExams);
  }
}

// [
//   ExamModel(
//     id: 1,
//     title: "multimedia 2023-2024",
//     questionsNumber: 3,
//     markingSchemes: [
//       MarkingSchemeModel(
//         id: 1,
//         title: "A",
//         questions: [
//           QuestionModel(number: 1, answer: "a"),
//           QuestionModel(number: 2, answer: "d"),
//           QuestionModel(number: 3, answer: "a"),
//         ],
//       ),
//       MarkingSchemeModel(
//         id: 2,
//         title: "B",
//         questions: [
//           QuestionModel(number: 1, answer: "a"),
//           QuestionModel(number: 2, answer: "d"),
//           QuestionModel(number: 3, answer: "a"),
//         ],
//       ),
//     ],
//   ),
//   ExamModel(
//     id: 2,
//     title: "KBS 2022-2023",
//     questionsNumber: 4,
//     markingSchemes: [
//       MarkingSchemeModel(
//         id: 1,
//         title: "A",
//         questions: [
//           QuestionModel(number: 1, answer: "a"),
//           QuestionModel(number: 2, answer: "d"),
//           QuestionModel(number: 3, answer: "a"),
//           QuestionModel(number: 4, answer: "d"),
//         ],
//       ),
//     ],
//   ),
// ],
