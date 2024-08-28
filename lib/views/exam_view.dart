import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/edit_exam_controller.dart';
import 'package:project2/controllers/exam_controller.dart';
import 'package:project2/controllers/exams_controller.dart';
import 'package:project2/models/exam_model.dart';
import 'package:project2/services/remote_services/exam_deletion_service.dart';
import 'package:project2/services/remote_services/exam_service.dart';
import 'package:project2/services/remote_services/exam_update_service.dart';
import 'package:project2/services/remote_services/marking_scheme_creation_service.dart';
import 'package:project2/services/remote_services/marking_scheme_deletion_service.dart';
import 'package:project2/services/remote_services/marking_scheme_update_service.dart';
import 'package:project2/views/marking_schemes_view.dart';

import '../constants.dart';
import '../models/class_model.dart';
import '../services/remote_services/classes_service.dart';
import 'components/my_button.dart';
import 'components/my_field.dart';

class ExamView extends StatelessWidget {
  final ExamModel exam;
  const ExamView({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    ExamsController esC = Get.find();
    ExamController eC = Get.put(
      ExamController(
        markingSchemeCreationService: MarkingSchemeCreationService(),
        markingSchemeDeletionService: MarkingSchemeDeletionService(),
        markingSchemeUpdateService: MarkingSchemeUpdateService(),
        examDeletionService: ExamDeletionService(),
        examService: ExamService(),
        examsController: esC,
        ogExam: exam,
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "exam details".tr,
            style: tt.titleLarge!.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w500),
          ),
          backgroundColor: kAppBarColor,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: Text(
                      "do you wanna delete this exam?".tr,
                      style: tt.headlineSmall!.copyWith(color: cs.onSurface),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          "no".tr,
                          style: tt.titleMedium!.copyWith(color: cs.onSurface),
                        ),
                      ),
                      TextButton(
                        onPressed: () => eC.deleteExam(),
                        child: Text(
                          "yes".tr,
                          style: tt.titleMedium!.copyWith(color: cs.error),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(
                Icons.delete,
                color: cs.error,
              ),
            ),
            IconButton(
              onPressed: () {
                //todo: ignore it, server is returning a wrong response(only title changed)
                Get.bottomSheet(
                  BottomSheet(
                    onClosing: () {},
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height / 0.8,
                      color: cs.surface,
                      child: GetBuilder<EditExamController>(
                        init: EditExamController(
                          examUpdateService: ExamUpdateService(),
                          classesService: ClassesService(),
                          examsController: esC,
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
                                      "edit exam".tr,
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
                                    await controller.editExam(exam); // remove await if animation lags
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
              icon: Icon(
                Icons.edit,
                color: cs.secondary,
              ),
            ),
          ],
        ),
        backgroundColor: cs.background,
        body: GetBuilder<ExamController>(
          builder: (controller) {
            return !controller.loadingExam
                ? Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.text_snippet_outlined),
                        title: Text(
                          "title".tr,
                          style: tt.titleMedium!.copyWith(color: cs.onSurface),
                        ),
                        subtitle: Text(
                          exam.title,
                          style: tt.titleSmall!.copyWith(color: cs.onBackground),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: const Icon(Icons.access_time_outlined),
                        title: Text(
                          "added at".tr, //todo: format with jiffy
                          style: tt.titleMedium!.copyWith(color: cs.onSurface),
                        ),
                        subtitle: Text(
                          exam.date.toIso8601String(),
                          style: tt.titleSmall!.copyWith(color: cs.onBackground),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: const Icon(Icons.numbers),
                        title: Text(
                          "number of questions".tr,
                          style: tt.titleMedium!.copyWith(color: cs.onSurface),
                        ),
                        subtitle: Text(
                          exam.questionsCount.toString(),
                          style: tt.titleSmall!.copyWith(color: cs.onBackground),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: const Icon(Icons.credit_score_outlined),
                        title: Text(
                          "pass score".tr,
                          style: tt.titleMedium!.copyWith(color: cs.onSurface),
                        ),
                        subtitle: Text(
                          "${exam.passMark.toString()} ${"of".tr} ${exam.completeMark.toString()}",
                          style: tt.titleSmall!.copyWith(color: cs.onBackground),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: const Icon(Icons.abc),
                        title: Text(
                          "marking schemes".tr,
                          style: tt.titleMedium!.copyWith(color: cs.onSurface),
                        ),
                        subtitle: Text(
                          "${controller.ogExam.markingSchemes.length} schemes",
                          style: tt.titleSmall!.copyWith(color: cs.onBackground),
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            Get.to(() => MarkingSchemesView(exam: exam));
                          },
                          child: Text(
                            "show".tr,
                            style: tt.titleMedium!.copyWith(color: cs.secondary, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  )
                : Center(child: SpinKitCubeGrid(color: cs.onBackground));
          },
        ),
      ),
    );
  }
}
