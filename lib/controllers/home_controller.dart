import 'package:get/get.dart';
import 'package:project2/models/exam_model.dart';
import 'package:project2/models/user_model.dart';
import 'package:project2/services/local_services/exam_selection_service.dart';
import 'package:project2/services/remote_services/logout_service.dart';
import 'package:project2/services/remote_services/my_profile_service.dart';
import 'package:project2/views/login_view.dart';

class HomeController extends GetxController {
  HomeController({logoutService, myProfileService, examSelectionService}) {
    _logoutService = logoutService;
    _myProfileService = myProfileService;
    _examSelectionService = examSelectionService;
  }

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

  late LogoutService _logoutService;
  late MyProfileService _myProfileService;
  late ExamSelectionService _examSelectionService;

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
          questionsNumber: 3,
          markingSchemes: [
            MarkingSchemeModel(
              id: 1,
              title: "A",
              questions: [
                QuestionModel(number: 1, answer: "a"),
                QuestionModel(number: 2, answer: "d"),
                QuestionModel(number: 3, answer: "a"),
              ],
            ),
            MarkingSchemeModel(
              id: 2,
              title: "B",
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
          questionsNumber: 4,
          markingSchemes: [
            MarkingSchemeModel(
              id: 1,
              title: "A",
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

  //

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  void getCurrentUser() async {
    // loading indicator
    _currentUser = await _myProfileService.getCurrentUser();
    update();
  }

  //

  void logout() async {
    if (await _logoutService.logout()) Get.offAll(const LoginView());
  }
}
