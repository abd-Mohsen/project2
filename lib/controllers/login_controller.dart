import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project2/services/remote_services/login_service.dart';
import 'package:project2/views/home_view.dart';

class LoginController extends GetxController {
  @override
  void onClose() {
    // email.dispose();
    // password.dispose();
    super.onClose();
  }

  late LoginService loginService;
  LoginController({required this.loginService});

  //final GetStorage _getStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
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

  void login() async {
    if (_isLoading) return;
    buttonPressed = true;
    bool isValid = loginFormKey.currentState!.validate();
    if (!isValid) return;
    toggleLoading(true);

    if (await loginService.login(email.text, password.text)) {
      Get.offAll(const HomeView());
    } else {
      print("failed to login");
    }
    toggleLoading(false);
  }
}
