import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/home_controller.dart';
import 'package:project2/models/exam_model.dart';
import 'package:project2/views/components/exam_card.dart';
import 'package:project2/views/exam_view.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.bottomSheet(
          //   BottomSheet(
          //     onClosing: () {},
          //     builder: (context) => Container(
          //       height: MediaQuery.of(context).size.height/0.8,
          //       color: cs.surface,
          //       child: GetBuilder<>(
          //         builder: (controller) {
          //           return ListView(
          //             children: [
          //               TextFormField(),
          //               ...List.generate(length, (index) => null)
          //             ],
          //           );
          //         }
          //       ),
          //     ),
          //   ),
          // );
        },
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<HomeController>(builder: (controller) {
        return ListView.builder(
          padding: const EdgeInsets.only(top: 4),
          itemCount: hC.exams.length,
          itemBuilder: (context, i) {
            ExamModel exam = hC.exams[i];
            return ExamCard(
              exam: exam,
              onTap: () {
                controller.selectExam(exam);
              },
              onTapOptions: () {
                Get.to(() => ExamView(exam: exam));
              },
              isSelected: exam.id == hC.selectedExamID,
            );
          },
        );
      }),
    );
  }
}
