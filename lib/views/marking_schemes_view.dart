import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/exam_controller.dart';
import 'package:project2/models/exam_model.dart';
import 'package:project2/views/components/marking_scheme_card.dart';
import 'package:project2/views/components/marking_scheme_sheet.dart';

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
            //todo refactor all sheets
            MarkingSchemeSheet(), // dont add const, it wont rebuilt
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
