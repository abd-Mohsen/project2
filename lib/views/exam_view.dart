import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/models/exam_model.dart';
import 'package:project2/views/components/marking_scheme_card.dart';

class ExamView extends StatelessWidget {
  final ExamModel exam;
  const ExamView({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
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
          //todo bottomsheet (un dismissible by clicking outside)
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.text_snippet_outlined),
            title: Text("title".tr),
            subtitle: Text(exam.title),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.access_time_outlined),
            title: Text("added at".tr),
            subtitle: Text(DateTime.now().toIso8601String()),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.abc),
            title: Text("marking schemes".tr),
            subtitle: Text("${exam.markingSchemes.length} schemes"),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              itemCount: exam.markingSchemes.length,
              itemBuilder: (context, i) {
                MarkingSchemeModel markingScheme = exam.markingSchemes[i];
                return MarkingSchemeCard(markingScheme: markingScheme);
              },
            ),
          )
        ],
      ),
    );
  }
}
