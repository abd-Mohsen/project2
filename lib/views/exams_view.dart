import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/home_controller.dart';
import 'package:project2/models/exam_model.dart';
import 'package:project2/views/components/exam_card.dart';

class ExamsView extends StatelessWidget {
  const ExamsView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController hC = Get.find();
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "select exam".tr,
          style: tt.titleLarge!.copyWith(color: cs.onPrimary, fontWeight: FontWeight.bold),
        ),
        backgroundColor: cs.primary,
        centerTitle: true,
      ),
      backgroundColor: cs.background,
      body: GetBuilder<HomeController>(builder: (controller) {
        return ListView.builder(
          itemCount: hC.exams.length,
          itemBuilder: (context, i) {
            ExamModel exam = hC.exams[i];
            return ExamCard(
              exam: exam,
              onTap: () {
                controller.selectExam(exam);
              },
              onTapOptions: () {
                //
              },
              isSelected: exam.id == hC.selectedExamID,
            );
          },
        );
      }),
    );
  }
}
