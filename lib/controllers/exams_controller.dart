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

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void toggleLoading(bool value) {
    _isLoading = value;
    update();
  }

  final List<ExamModel> exams = [];
  int _selectedExamID = -1;
  int get selectedExamID => _selectedExamID;

  void selectExam(ExamModel exam) {
    examSelectionService.saveSelectedExamId(exam.id);
    _selectedExamID = exam.id;
    update();
  }

  void unSelectExam() {
    examSelectionService.clearSelectedExamId();
    _selectedExamID = -1;
  }

  Future getExams() async {
    toggleLoading(true);
    List<ExamModel> newExams = await examsService.getAllExams() ?? [];
    exams.addAll(newExams);
    toggleLoading(false);
  }

  void addExam(ExamModel exam) {
    exams.add(exam);
    update();
  }

  void delete(ExamModel exam) {
    exams.remove(exam);
    update();
  }

  void editExam(ExamModel newExam) {
    exams.where((exam) => exam.id == newExam.id).toList()[0] = newExam;
    update();
  }
}
