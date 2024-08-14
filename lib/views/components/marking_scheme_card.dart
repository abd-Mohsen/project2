import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/models/exam_model.dart';
import 'package:project2/views/components/question_card.dart';

class MarkingSchemeCard extends StatelessWidget {
  final MarkingSchemeModel markingScheme;
  const MarkingSchemeCard({super.key, required this.markingScheme});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        //todo: edit and delete
        title: Text(markingScheme.title),
        textColor: cs.secondary,
        collapsedTextColor: cs.onSurface,
        iconColor: cs.secondary,
        collapsedIconColor: cs.onSurface,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: cs.onBackground,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        collapsedShape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.5,
            color: cs.onBackground.withOpacity(0.6),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        children: [
          const QuestionCardLabels(),
          ...List.generate(
            markingScheme.questions.length,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: QuestionCard(
                number: markingScheme.questions[i].number,
                answer: markingScheme.questions[i].answer,
              ),
            ),
          ),
          // ...List.generate(
          //   50,
          //   (i) => Padding(
          //     padding: const EdgeInsets.only(bottom: 4),
          //     child: QuestionCard(
          //       number: i + 5,
          //       answer: 'a',
          //     ),
          //   ),
          // ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  //
                },
                child: Text(
                  "edit".tr,
                  style: tt.titleMedium!.copyWith(color: cs.secondary),
                ),
              ),
              TextButton(
                onPressed: () {
                  //
                },
                child: Text(
                  "delete".tr,
                  style: tt.titleMedium!.copyWith(color: cs.error),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
