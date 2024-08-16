import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/class_model.dart';

class AddExamController extends GetxController {
  @override
  void onInit() {
    getClasses();
    super.onInit();
  }

  TextEditingController title = TextEditingController();
  TextEditingController totalScore = TextEditingController(text: "100");
  TextEditingController passScore = TextEditingController(text: "60");
  TextEditingController questionsNumber = TextEditingController(text: "20");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isButtonPressed = false;

  ClassModel? selectedClass;
  List<ClassModel> classes = [];

  void selectClass(ClassModel? c) {
    selectedClass = c;
    update(); //do i need it?
  }

  void getClasses() async {
    //
  }
}
