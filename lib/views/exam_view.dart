import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/exam_controller.dart';
import 'package:project2/models/exam_model.dart';
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
    //ExamController eC = Get.put(ExamController(exam));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "exam details".tr,
          style: tt.titleLarge!.copyWith(color: cs.onPrimary, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kAppBarColor,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //todo: show confirmation then delete
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
        init: ExamController(
          exam: exam,
          markingSchemeCreationService: MarkingSchemeCreationService(),
          markingSchemeDeletionService: MarkingSchemeDeletionService(),
          markingSchemeUpdateService: MarkingSchemeUpdateService(),
        ),
        builder: (controller) {
          return Column(
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
                  "added at".tr,
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
                  "${controller.exam.markingSchemes.length} schemes",
                  style: tt.titleSmall!.copyWith(color: cs.onBackground),
                ),
                trailing: TextButton(
                  onPressed: () {
                    Get.to(() => MarkingSchemesView(exam: exam));
                  },
                  child: Text(
                    "show".tr,
                    style: tt.titleMedium!.copyWith(color: cs.secondary),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
