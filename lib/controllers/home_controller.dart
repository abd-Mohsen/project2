import 'package:get/get.dart';
import 'package:project2/models/exam_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    getExams();
    super.onInit();
  }

  @override
  void dispose() {
    //
    super.dispose();
  }

  List<ExamModel> exams = [];

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
          id: 1,
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
                QuestionModel(number: 3, answer: "d"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
