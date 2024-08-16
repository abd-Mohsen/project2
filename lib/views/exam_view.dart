import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/exam_controller.dart';
import 'package:project2/models/exam_model.dart';
import 'package:project2/views/components/marking_scheme_card.dart';
import 'package:project2/views/components/my_field.dart';
import 'package:project2/views/components/selectable_question_card.dart';

class ExamView extends StatelessWidget {
  final ExamModel exam;
  const ExamView({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    ExamController eC = Get.put(ExamController(exam));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "exam details".tr,
          style: tt.titleLarge!.copyWith(color: cs.onPrimary, fontWeight: FontWeight.bold),
        ),
        backgroundColor: cs.primary,
        centerTitle: true,
      ),
      backgroundColor: cs.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          eC.initCreateScheme(exam.questionsNumber);
          Get.bottomSheet(
            BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height / 0.8,
                  color: cs.surface,
                  child: GetBuilder<ExamController>(
                    builder: (controller) {
                      return Form(
                        key: controller.formKey,
                        child: ListView(
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Center(
                            //     child: Text(
                            //       "new marking scheme".tr,
                            //       style: tt.headlineMedium!.copyWith(
                            //         color: cs.onSurface,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //   ),
                            // ),
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
                            ...List.generate(
                              controller.questions.length,
                              (i) => SelectableQuestionCard(
                                question: controller.questions[i],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 72),
                              child: GestureDetector(
                                onTap: () async {
                                  await controller.addMarkingScheme();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: cs.secondary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Center(
                                      child: Text(
                                        "add".tr,
                                        style: tt.headlineMedium!.copyWith(
                                          color: cs.onSecondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
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
              DateTime.now().toIso8601String(),
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
              "${exam.markingSchemes.length} schemes",
              style: tt.titleSmall!.copyWith(color: cs.onBackground),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GetBuilder<ExamController>(builder: (con) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                itemCount: exam.markingSchemes.length,
                itemBuilder: (context, i) {
                  return MarkingSchemeCard(markingScheme: exam.markingSchemes[i]);
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
