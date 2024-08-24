import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:project2/views/components/selectable_question_card.dart';
import '../../controllers/exam_controller.dart';
import '../../models/marking_scheme_model.dart';
import 'my_button.dart';
import 'my_field.dart';

class MarkingSchemeSheet extends StatelessWidget {
  final MarkingSchemeModel? markingScheme;
  const MarkingSchemeSheet({super.key, this.markingScheme});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 0.8,
          color: cs.surface,
          child: GetBuilder<ExamController>(
            builder: (controller) {
              return Form(
                key: controller.formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 24),
                      child: Center(
                        child: Text(
                          "${markingScheme == null ? "new".tr : "edit".tr} ${"marking scheme".tr}",
                          style: tt.headlineMedium!.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ...List.generate(
                      markingScheme == null ? controller.questions.length : controller.questions2.length,
                      (i) => SelectableQuestionCard(
                        question: markingScheme == null ? controller.questions[i] : controller.questions2[i],
                      ),
                    ),
                    MyField(
                      controller: controller.title,
                      title: "title".tr,
                      validator: (s) {
                        return validateInput(s!, 0, 100, "text");
                      },
                      onChanged: (s) {
                        if (controller.isButtonPressed) controller.formKey.currentState!.validate();
                      },
                    ),
                    MyButton(
                      onTap: () async {
                        markingScheme == null
                            ? await controller.addMarkingScheme()
                            : await controller.editMarkingScheme(markingScheme!); // remove await if animation lags
                      },
                      child: controller.loading
                          ? SpinKitThreeBounce(
                              color: cs.onSecondary,
                              size: 27,
                            )
                          : Text(
                              markingScheme == null ? "add".tr : "edit".tr,
                              style: tt.headlineMedium!.copyWith(
                                color: cs.onSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
