import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/exams_controller.dart';
import 'package:project2/services/remote_services/classes_service.dart';
import 'package:project2/services/remote_services/exam_update_service.dart';

import '../models/class_model.dart';
import '../models/exam_model.dart';

class EditExamController extends GetxController {
  EditExamController({
    required this.examUpdateService,
    required this.classesService,
    required this.examsController,
  });
  @override
  void onInit() {
    getClasses();
    super.onInit();
  }

  late ExamUpdateService examUpdateService;
  late ClassesService classesService;
  late ExamsController examsController; // find a cleaner way to do this
  //todo: add "change template"

  TextEditingController title = TextEditingController();
  TextEditingController totalScore = TextEditingController(text: "100");
  TextEditingController passScore = TextEditingController(text: "60");
  TextEditingController questionsNumber = TextEditingController(text: "20");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isButtonPressed = false;

  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool value) {
    _loading = value;
    update();
  }

  ClassModel? selectedClass;
  List<ClassModel> classes = [];

  void selectClass(ClassModel? c) {
    selectedClass = c;
    update(); //do i need it?
  }

  void getClasses() async {
    classes = await classesService.getAllClasses() ?? [];
    update();
  }

  Future editExam(ExamModel exam) async {
    if (_loading) return;
    isButtonPressed = true;
    if (!formKey.currentState!.validate()) return;
    setLoading(true);
    ExamModel? newExam = await examUpdateService.editExam(
      exam.id,
      title.text,
      passScore.text,
      totalScore.text,
      questionsNumber.text,
      selectedClass!.id,
    );
    if (newExam == null) {
      print("failed to edit");
      return;
    }
    examsController.editExam(newExam);
    Get.back();
    setLoading(false);
    //
  }
}
