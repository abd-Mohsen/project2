import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final int number;
  final String answer;
  const QuestionCard({
    super.key,
    required this.number,
    required this.answer,
  });

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
              backgroundColor: i == answer.codeUnitAt(0) - 97 ? cs.onSurface : cs.onSurface.withOpacity(0.2),
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
              "${number.toString()}.",
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
