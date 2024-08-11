import 'package:flutter/material.dart';
import 'package:project2/models/exam_model.dart';

class MarkingSchemeCard extends StatelessWidget {
  final MarkingSchemeModel markingScheme;
  const MarkingSchemeCard({super.key, required this.markingScheme});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return ExpansionTile(
      //todo: edit and delete
      title: Text(markingScheme.title),
      textColor: cs.secondary,
      iconColor: cs.secondary,
      children: List.generate(
        markingScheme.questions.length,
        (i) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            "${markingScheme.questions[i].number}  --->  ${markingScheme.questions[i].answer}",
            style: tt.titleMedium!.copyWith(color: cs.onBackground),
          ),
        ),
      ),
    );
  }
}
