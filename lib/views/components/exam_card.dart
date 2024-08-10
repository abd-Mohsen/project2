import 'package:flutter/material.dart';
import 'package:project2/models/exam_model.dart';

class ExamCard extends StatelessWidget {
  final ExamModel exam;
  final void Function() onTap;
  final void Function() onTapOptions;
  final bool isSelected;

  const ExamCard({
    super.key,
    required this.exam,
    required this.onTap,
    required this.onTapOptions,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return ListTile(
      title: Text(
        exam.title,
        style: tt.titleMedium!.copyWith(color: cs.onBackground),
      ),
      onTap: onTap,
      trailing: IconButton(
        onPressed: onTapOptions,
        icon: Icon(Icons.more_horiz_rounded),
      ),
    );
  }
}
