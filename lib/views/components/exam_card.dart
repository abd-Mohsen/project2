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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.text_snippet_outlined),
        title: Text(
          exam.title,
          maxLines: 2,
          style: tt.titleMedium!.copyWith(color: cs.onBackground),
        ),
        subtitle: Text(
          exam.examClass.title,
          maxLines: 1,
          style: tt.titleSmall!.copyWith(color: cs.onBackground.withOpacity(0.7)),
        ),
        onTap: onTap,
        onLongPress: onTapOptions,
        trailing: IconButton(
          onPressed: onTapOptions,
          icon: Icon(Icons.settings),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: isSelected ? 2 : 1,
            color: isSelected ? cs.secondary : cs.onBackground.withOpacity(0.6),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
