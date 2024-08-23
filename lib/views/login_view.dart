import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:project2/views/register_view.dart';
import 'package:project2/views/reset_password_view1.dart';
import '../constants.dart';
import '../controllers/login_controller.dart';
import '../services/remote_services/login_service.dart';
import 'components/auth_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    LoginController lC = Get.put(LoginController(loginService: LoginService()));
    return WillPopScope(
      onWillPop: () async {
        Get.dialog(kCloseAppDialog());
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: cs.background,
          body: Form(
            key: lC.loginFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 48),
                    child: Hero(
                      tag: "logo",
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/images/${Get.isDarkMode ? "logo_dark" : "logo"}.png",
                            height: MediaQuery.sizeOf(context).width / 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                    child: Text(
                      'login to your account',
                      style: tt.headlineMedium!.copyWith(color: cs.onBackground),
                    ),
                  ),
                  AuthField(
                    label: "user name",
                    controller: lC.email,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.person_outline),
                    validator: (val) {
                      return validateInput(lC.email.text, 2, 50, "name");
                    },
                    onChanged: (val) {
                      if (lC.buttonPressed) lC.loginFormKey.currentState!.validate();
                    },
                  ),
                  const SizedBox(height: 8),
                  GetBuilder<LoginController>(
                    builder: (con) => AuthField(
                      controller: lC.password,
                      keyboardType: TextInputType.text,
                      obscure: !con.passwordVisible,
                      label: "password",
                      prefixIcon: Icon(CupertinoIcons.lock),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          con.togglePasswordVisibility(!con.passwordVisible);
                        },
                        child: Icon(con.passwordVisible ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
                      ),
                      validator: (val) {
                        return validateInput(lC.password.text, 4, 50, "password");
                      },
                      onChanged: (val) {
                        if (con.buttonPressed) con.loginFormKey.currentState!.validate();
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                        onPressed: () {
                          Get.to(const ResetPasswordView1());
                        },
                        child: Text(
                          "forgot password?".tr,
                          style: tt.labelLarge!.copyWith(color: cs.onBackground.withOpacity(0.6)),
                        ),
                      ),
                    ),
                  ),
                  GetBuilder<LoginController>(
                    builder: (con) => Center(
                      child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: cs.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: con.isLoading
                              ? SpinKitThreeBounce(color: cs.onPrimary, size: 24)
                              : Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    "Login",
                                    style: tt.titleMedium!.copyWith(color: cs.onSecondary),
                                  ),
                                ),
                        ),
                        onTap: () {
                          con.login();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "no account?",
                          style: tt.titleMedium!.copyWith(color: cs.onBackground),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const RegisterView());
                          },
                          child: Text(
                            "register here",
                            style: tt.titleMedium!.copyWith(color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: Text(
                        "AdaDevs® ${"all rights reserved".tr}",
                        style: tt.labelMedium!.copyWith(color: cs.onBackground.withOpacity(0.6)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
