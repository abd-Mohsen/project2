import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/exams_controller.dart';
import 'package:project2/services/remote_services/classes_service.dart';
import 'package:project2/services/remote_services/exam_creation_service.dart';

import '../models/class_model.dart';
import '../models/exam_model.dart';

class AddExamController extends GetxController {
  AddExamController({
    required this.examCreationService,
    required this.classesService,
    required this.examsController,
  });
  @override
  void onInit() {
    getClasses();
    super.onInit();
  }

  late ExamCreationService examCreationService;
  late ClassesService classesService;
  late ExamsController examsController; //todo: find a cleaner way to do this

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

  Future addExam() async {
    if (_loading) return;
    isButtonPressed = true;
    if (!formKey.currentState!.validate()) return;
    setLoading(true);
    ExamModel? newExam = await examCreationService.addExam(
      title.text,
      passScore.text,
      totalScore.text,
      questionsNumber.text,
      selectedClass!.id,
    );
    if (newExam == null) {
      print("failed to add");
      return;
    }
    examsController.addExam(newExam);
    Get.back();
    setLoading(false);
    //
  }
}
