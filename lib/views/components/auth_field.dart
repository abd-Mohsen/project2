import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.controller,
    this.keyboardType,
    required this.label,
    this.obscure,
    required this.prefixIcon,
    this.suffixIcon,
    required this.validator,
    required this.onChanged,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String label;
  final bool? obscure;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?) validator;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: obscure ?? false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            //borderSide: BorderSide(color: cs.secondary),
          ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: cs.secondary),
          // ),
          //hintText: "password".tr,
          label: Text(label),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          //
        ),
        style: tt.titleMedium!.copyWith(color: cs.onBackground),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}

String? validateInput(String val, int min, int max, String type,
    {String pass = "", String rePass = "", bool canBeEmpty = false}) {
  if (val.trim().isEmpty && !canBeEmpty) return "cannot be empty".tr;

  if (type == "username") {
    if (!GetUtils.isUsername(val)) return "invalid username".tr;
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) return "invalid email".tr;
  }
  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) return "invalid phone".tr;
  }
  if (val.length < min) return "${"cannot be shorter".tr} than $min ${"characters".tr}";
  if (val.length > max) return "${"cannot be longer".tr} than $max ${"characters".tr}";

  if (pass != rePass) return "passwords don't match".tr;

  return null;
}
