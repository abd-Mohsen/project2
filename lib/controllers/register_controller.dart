import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/user_model.dart';

class RegisterController extends GetxController {
  @override
  void onClose() {
    // email.dispose();
    // password.dispose();
    // rePassword.dispose();
    // fName.dispose();
    // lName.dispose();
    // phone.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    //getSupervisorsNames();
    super.onInit();
  }

  final userName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final rePassword = TextEditingController();
  final phone = TextEditingController();
  String roleINEnglish = "supervisor";
  String selectedRole = "personal";
  UserModel? selectedSupervisor; //(show if role is 3)

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  bool buttonPressed = false;

  bool _isLoadingRegister = false;
  bool get isLoading => _isLoadingRegister;
  void toggleLoadingRegister(bool value) {
    _isLoadingRegister = value;
    update();
  }

  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;
  void togglePasswordVisibility(bool value) {
    _passwordVisible = value;
    update();
  }

  bool _rePasswordVisible = false;
  bool get rePasswordVisible => _rePasswordVisible;
  void toggleRePasswordVisibility(bool value) {
    _rePasswordVisible = value;
    update();
  }

  void setRole(String role) {
    role == "مشرف" ? roleINEnglish = "supervisor" : roleINEnglish = "salesman";
    selectedRole = role;
    update();
  }

  void setSupervisor(UserModel supervisor) {
    selectedSupervisor = supervisor;
    update();
  }

  List<UserModel> availableSupervisors = [];
  Future<void> getSupervisorsNames() async {
    List<UserModel> supervisors = [];
    for (UserModel supervisor in supervisors) {
      availableSupervisors.add(supervisor);
    }
    update();
  }

  Future register() async {
    buttonPressed = true;
    bool isValid = registerFormKey.currentState!.validate();
    if (!isValid) return;
    toggleLoadingRegister(true);
    try {
      bool success = 1 == 2;
      // (await RemoteServices.register(
      //   userName.text,
      //   email.text,
      //   password.text,
      //   rePassword.text,
      //   phone.text,
      //   roleINEnglish,
      //   selectedSupervisor?.id,
      // ).timeout(kTimeOutDuration));
      if (success) {
        //
      }
    } on TimeoutException {
      kTimeOutDialog();
    } catch (e) {
      print(e.toString());
    } finally {
      toggleLoadingRegister(false);
    }
  }
}
