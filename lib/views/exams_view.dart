import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/add_exam_controller.dart';
import 'package:project2/controllers/exams_controller.dart';
import 'package:project2/models/class_model.dart';
import 'package:project2/models/exam_model.dart';
import 'package:project2/services/local_services/exam_selection_service.dart';
import 'package:project2/services/remote_services/classes_service.dart';
import 'package:project2/services/remote_services/exam_creation_service.dart';
import 'package:project2/services/remote_services/exams_service.dart';
import 'package:project2/views/components/exam_card.dart';
import 'package:project2/views/exam_view.dart';

import '../constants.dart';
import 'components/my_button.dart';
import 'components/my_field.dart';

class ExamsView extends StatelessWidget {
  const ExamsView({super.key});

  @override
  Widget build(BuildContext context) {
    //HomeController hC = Get.find();
    ExamsController eC = Get.put(
      ExamsController(
        examSelectionService: ExamSelectionService(),
        examsService: ExamsService(),
      ),
    );
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "select exam".tr,
          style: tt.titleLarge!.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w500),
        ),
        backgroundColor: kAppBarColor,
        centerTitle: true,
      ),
      backgroundColor: cs.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            BottomSheet(
              onClosing: () {},
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height / 0.8,
                color: cs.surface,
                child: GetBuilder<AddExamController>(
                  init: AddExamController(
                    examCreationService: ExamCreationService(),
                    classesService: ClassesService(),
                    examsController: eC,
                  ),
                  builder: (controller) {
                    // separate controller (and add classes before exam)
                    return Form(
                      key: controller.formKey,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "new exam".tr,
                                style: tt.headlineMedium!.copyWith(
                                  color: cs.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          MyField(
                            controller: controller.title,
                            title: "title".tr,
                            validator: (s) {
                              return validateInput(s!, 0, 100, "text");
                            },
                            onChanged: (s) {
                              if (controller.isButtonPressed) controller.formKey.currentState!.validate();
                            },
                          ),
                          MyField(
                            controller: controller.totalScore,
                            keyboardType: TextInputType.number,
                            title: "total score".tr,
                            validator: (s) {
                              return validateInput(
                                s!,
                                0,
                                0,
                                "num",
                                minValue: int.parse(controller.passScore.text),
                                maxValue: 100,
                              );
                            },
                            onChanged: (s) {
                              if (controller.isButtonPressed) controller.formKey.currentState!.validate();
                            },
                          ),
                          MyField(
                            controller: controller.passScore,
                            keyboardType: TextInputType.number,
                            title: "pass score".tr,
                            validator: (s) {
                              return validateInput(
                                s!,
                                0,
                                0,
                                "num",
                                minValue: 0,
                                maxValue: int.parse(controller.totalScore.text),
                              );
                            },
                            onChanged: (s) {
                              if (controller.isButtonPressed) controller.formKey.currentState!.validate();
                            },
                          ),
                          MyField(
                            controller: controller.questionsNumber,
                            keyboardType: TextInputType.number,
                            title: "number of questions".tr,
                            validator: (s) {
                              return validateInput(
                                s!,
                                0,
                                0,
                                "num",
                                minValue: 0,
                                maxValue: 100,
                              );
                            },
                            onChanged: (s) {
                              if (controller.isButtonPressed) controller.formKey.currentState!.validate();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                            child: DropdownSearch<ClassModel>(
                              validator: (user) {
                                if (controller.selectedClass == null) return "select a class first".tr;
                                return null;
                              },
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    fillColor: Colors.white70,
                                    hintText: "class title".tr,
                                    prefix: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Icon(Icons.search, color: cs.onSurface),
                                    ),
                                  ),
                                ),
                              ),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "class".tr,
                                  labelStyle: tt.titleMedium!.copyWith(color: cs.onSurface.withOpacity(0.6)),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                              items: controller.classes,
                              itemAsString: (ClassModel c) => c.title,
                              onChanged: (ClassModel? c) async {
                                controller.selectClass(c);
                                await Future.delayed(const Duration(milliseconds: 1000));
                                if (controller.isButtonPressed) controller.formKey.currentState!.validate();
                              },
                              //enabled: !con.enabled,
                            ),
                          ),
                          MyButton(
                            onTap: () async {
                              await controller.addExam(); // remove await if animation lags
                            },
                            child: controller.loading
                                ? CircularProgressIndicator()
                                : Text(
                                    "add".tr,
                                    style: tt.headlineMedium!.copyWith(
                                      color: cs.onSecondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<ExamsController>(
        builder: (controller) {
          return controller.isLoading
              ? SpinKitFoldingCube(color: cs.onBackground)
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 4),
                  itemCount: controller.exams.length,
                  itemBuilder: (context, i) {
                    ExamModel exam = controller.exams[i];
                    return ExamCard(
                      exam: exam,
                      onTap: () {
                        controller.selectExam(exam);
                      },
                      onTapOptions: () {
                        Get.to(() => ExamView(exam: exam));
                      },
                      isSelected: exam.id == controller.selectedExamID,
                    );
                  },
                );
        },
      ),
    );
  }
}
