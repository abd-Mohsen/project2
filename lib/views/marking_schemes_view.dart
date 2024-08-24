import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/exam_controller.dart';
import 'package:project2/models/exam_model.dart';
import 'package:project2/views/components/marking_scheme_card.dart';
import 'package:project2/views/components/my_button.dart';
import 'package:project2/views/components/my_field.dart';
import 'package:project2/views/components/selectable_question_card.dart';

import '../constants.dart';

class MarkingSchemesView extends StatelessWidget {
  final ExamModel exam;
  const MarkingSchemesView({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    ExamController eC = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "marking schemes".tr,
          style: tt.titleLarge!.copyWith(color: cs.onPrimary, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kAppBarColor,
        centerTitle: true,
      ),
      backgroundColor: cs.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          eC.initCreateScheme(exam.questionsCount);
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
                            Padding(
                              padding: const EdgeInsets.only(top: 24, bottom: 24),
                              child: Center(
                                child: Text(
                                  "${"new".tr} ${"marking scheme".tr}",
                                  style: tt.headlineMedium!.copyWith(
                                    color: cs.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            ...List.generate(
                              controller.questions.length,
                              (i) => SelectableQuestionCard(
                                question: controller.questions[i],
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
                            MyButton(
                              onTap: () async {
                                await controller.addMarkingScheme(); // remove await if animation lags
                              },
                              child: controller.loading
                                  ? SpinKitThreeBounce(
                                      color: cs.onSecondary,
                                      size: 27,
                                    )
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
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<ExamController>(
              builder: (con) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                  itemCount: exam.markingSchemes.length,
                  itemBuilder: (context, i) {
                    return MarkingSchemeCard(markingScheme: exam.markingSchemes[i]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
