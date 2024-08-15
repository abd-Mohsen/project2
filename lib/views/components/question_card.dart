import 'package:flutter/material.dart';
import 'package:project2/models/exam_model.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel question;
  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    drawChoices() {
      List<Widget> res = [];
      for (int i = 0; i < 5; i++) {
        res.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: CircleAvatar(
              radius: 6,
              backgroundColor: i == question.answer.codeUnitAt(0) - 97 ? cs.onSurface : cs.onSurface.withOpacity(0.2),
            ),
          ),
        );
      }
      return res;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 25,
            child: Text(
              "${question.number.toString()}.",
              style: tt.titleSmall!.copyWith(color: cs.onSurface),
            ),
          ),
          const SizedBox(width: 12),
          ...drawChoices(),
        ],
      ),
    );
  }
}

class QuestionCardLabels extends StatelessWidget {
  const QuestionCardLabels({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    drawLabels() {
      List<Widget> res = [];
      for (int i = 0; i < 5; i++) {
        res.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              String.fromCharCode(i + 97),
              style: tt.titleSmall!.copyWith(color: cs.onBackground),
            ),
          ),
        );
      }
      return res;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "..",
            style: tt.titleSmall!.copyWith(color: cs.background),
          ),
          const SizedBox(width: 28),
          ...drawLabels(),
        ],
      ),
    );
  }
}
