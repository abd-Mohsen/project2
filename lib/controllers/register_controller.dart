import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project2/services/remote_services/register_service.dart';
import '../views/home_view.dart';

class RegisterController extends GetxController {
  RegisterController({required this.registerService});
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

  String selectedRole = "personal".tr;
  int roleId = 2; //todo: checkout new roles

  late RegisterService registerService;

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  bool buttonPressed = false;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void toggleLoading(bool value) {
    _isLoading = value;
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
    role == "personal".tr ? roleId = 2 : roleId = 3;
    selectedRole = role;
    update();
  }

  void register() async {
    if (_isLoading) return;
    buttonPressed = true;
    bool isValid = registerFormKey.currentState!.validate();
    if (!isValid) return;
    toggleLoading(true);

    if (await registerService.register(userName.text, email.text, password.text, roleId)) {
      Get.offAll(const HomeView()); // go to login with success msg
    } else {
      print("failed to register");
    }
    toggleLoading(false);
  }
}
