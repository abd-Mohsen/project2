import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String? Function(String?) validator;
  final void Function(String?) onChanged;
  final IconData? iconData;
  final TextInputType? keyboardType;

  const MyField({
    super.key,
    required this.controller,
    required this.title,
    required this.validator,
    required this.onChanged,
    this.iconData,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          label: Text(
            title,
            style: tt.titleMedium!.copyWith(
              color: cs.onSurface.withOpacity(0.5),
            ),
          ),
          prefixIcon: Icon(
            iconData,
            color: cs.onSurface,
            size: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        style: tt.titleMedium!.copyWith(color: cs.onSurface),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}

String? validateInput(
  String val,
  int min,
  int max,
  String type, {
  bool canBeEmpty = false,
  int minValue = 0,
  int maxValue = 100,
}) {
  if (val.trim().isEmpty && !canBeEmpty) return "cannot be empty".tr;

  if (type == "num") {
    if (!GetUtils.isNum(val)) return "enter a whole number".tr;
    int num = 0;
    if (minValue > maxValue) return "values are not valid".tr;
    if (num > maxValue) return "${"cannot be greater".tr} than $maxValue";
    if (num < minValue) return "${"cannot be less".tr} than $minValue";
    return null;
  }
  if (val.length < min) return "${"cannot be shorter".tr} than $min ${"characters".tr}";
  if (val.length > max) return "${"cannot be longer".tr} than $max ${"characters".tr}";

  return null;
}
