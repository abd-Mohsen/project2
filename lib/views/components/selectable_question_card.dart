import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/exam_controller.dart';
import '../../models/question_model.dart';

class SelectableQuestionCard extends StatelessWidget {
  final QuestionModel question;
  const SelectableQuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    ExamController eC = Get.find();

    drawChoices() {
      List<Widget> res = [];
      for (int i = 0; i < 5; i++) {
        res.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () {
                eC.setChoice(question, String.fromCharCode(i + 97));
              },
              child: CircleAvatar(
                radius: 22,
                backgroundColor: i == question.answer.codeUnitAt(0) - 97 ? cs.secondary : cs.onSurface.withOpacity(0.2),
                child: Text(
                  String.fromCharCode(i + 97),
                  style: tt.titleSmall!.copyWith(color: cs.onSurface),
                ),
              ),
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
              style: tt.titleMedium!.copyWith(color: cs.onSurface),
            ),
          ),
          const SizedBox(width: 12),
          ...drawChoices(),
        ],
      ),
    );
  }
}
