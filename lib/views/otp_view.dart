import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../controllers/otp_controller.dart';
import '../controllers/reset_password_controller.dart';

class OTPView extends StatelessWidget {
  final String source;
  const OTPView({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    ResetPassController rPC = Get.find();
    //OTPController oC = Get.put(OTPController(source == "reset" ? rPC : null));
    //if there is an error, handle this above
    // this
    return SafeArea(
      child: Scaffold(
        backgroundColor: cs.background,
        body: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: GetBuilder<OTPController>(
                  init: OTPController(source == "reset" ? rPC : null),
                  builder: (con) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        !con.isTimeUp ? "valid till" : "expired",
                        style: tt.titleLarge!.copyWith(color: con.isTimeUp ? Colors.red : cs.onBackground),
                      ),
                      const SizedBox(height: 8),
                      Countdown(
                        controller: con.timeController,
                        seconds: 180,
                        build: (_, double time) => Text(
                          time.toString(),
                          style: tt.titleLarge!.copyWith(color: con.isTimeUp ? Colors.red : cs.onBackground),
                        ),
                        onFinished: () {
                          con.toggleTimerState(true);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Hero(
                  tag: "logo",
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: MediaQuery.sizeOf(context).width / 2.5,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Text(
                  'enter the code we sent to your email:',
                  style: tt.titleMedium!.copyWith(color: cs.onBackground),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 60, left: 12, right: 12),
                child: GetBuilder<OTPController>(
                  builder: (con) => OTPTextField(
                    controller: con.otpController,
                    otpFieldStyle: OtpFieldStyle(
                      focusBorderColor: cs.primary,
                      backgroundColor: Colors.grey.shade200,
                    ),
                    hasError: con.isTimeUp,
                    outlineBorderRadius: 15,
                    length: 5,
                    width: MediaQuery.of(context).size.width / 1.2,
                    fieldWidth: MediaQuery.of(context).size.width / 8,
                    style: tt.labelLarge!.copyWith(color: Colors.black),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    onCompleted: (pin) {
                      con.verifyOtp(pin);
                    },
                    onChanged: (val) {},
                  ),
                ),
              ),
              GetBuilder<OTPController>(
                builder: (con) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: !con.isTimeUp ? Colors.grey : cs.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: con.isLoading
                            ? SpinKitThreeBounce(
                                color: cs.onPrimary,
                                size: 28,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  "resend OTP",
                                  style: tt.titleMedium!.copyWith(color: cs.onPrimary),
                                ),
                              ),
                      ),
                    ),
                    onTap: () {
                      con.resendOtp();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
