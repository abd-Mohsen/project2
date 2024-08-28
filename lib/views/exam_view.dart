import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/exam_controller.dart';
import 'package:project2/controllers/exams_controller.dart';
import 'package:project2/models/exam_model.dart';
import 'package:project2/services/remote_services/exam_deletion_service.dart';
import 'package:project2/services/remote_services/exam_service.dart';
import 'package:project2/services/remote_services/marking_scheme_creation_service.dart';
import 'package:project2/services/remote_services/marking_scheme_deletion_service.dart';
import 'package:project2/services/remote_services/marking_scheme_update_service.dart';
import 'package:project2/views/marking_schemes_view.dart';

import '../constants.dart';

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
                //todo: handle edit
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
