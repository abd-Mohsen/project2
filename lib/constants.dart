import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

//String kHostIP = "http://192.168.1.34:8000";
String kHostIP = "http://10.0.2.2:8000";

//String fontFamily = 'Alexandria';

String kAppName = "AdaGrade";

const Color kAppBarColor = Color(0xff0f1432);

Duration kTimeOutDuration = const Duration(seconds: 25);
Duration kTimeOutDuration2 = const Duration(seconds: 15);
Duration kTimeOutDuration3 = const Duration(seconds: 7);

AlertDialog kAboutAppDialog() => AlertDialog(
      //todo: fix the dialog length, and add contact info for both company and dev
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            "ok",
            //style: tt.titleMedium?.copyWith(color: cs.primary),
          ),
        ),
      ],
      content: Column(
        children: [
          Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "تم تطوير هذا البرنامج لصالح شركة ليتيا المغفلة الخاصة, جميع الحقوق محفوظة",
                      //style: tt.headlineSmall!.copyWith(color: cs.onSurface),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

AlertDialog kCloseAppDialog() => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text("are you sure you want to quit the app?".tr),
      actions: [
        TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: Text(
              "yes",
              //style: kTextStyle20.copyWith(color: Colors.red),
            )),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "no".tr,
              //style: kTextStyle20,
            )),
      ],
    );

AlertDialog kSessionExpiredDialog() => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text("your session has expired please login again".tr),
      actions: [
        TextButton(
            onPressed: () {},
            child: Text(
              "yes".tr,
              //style: kTextStyle20.copyWith(color: Colors.red),
            )),
      ],
    );

Future kTimeOutDialog() => Get.defaultDialog(
      title: "error".tr,
      middleText: "operation is taking so long, please check your internet "
              "connection or try again later."
          .tr,
      middleTextStyle: const TextStyle(color: Colors.black),
      titleStyle: const TextStyle(color: Colors.black),
    );

TextTheme kMyTextTheme(String fontFamily) => TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        //wordSpacing: 64,
        letterSpacing: 0,
        fontFamily: fontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        //wordSpacing: 52,
        letterSpacing: 0,
        fontFamily: fontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        //wordSpacing: 44,
        letterSpacing: 0,
        fontFamily: fontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        //wordSpacing: 40,
        letterSpacing: 0,
        fontFamily: fontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        //wordSpacing: 36,
        letterSpacing: 0,
        fontFamily: fontFamily,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        //wordSpacing: 32,
        letterSpacing: 0,
        fontFamily: fontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        //wordSpacing: 28,
        letterSpacing: 0,
        fontFamily: fontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        //wordSpacing: 24,
        letterSpacing: 0.15,
        fontFamily: fontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        //wordSpacing: 20,
        letterSpacing: 0.1,
        fontFamily: fontFamily,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        //wordSpacing: 20,
        letterSpacing: 0.1,
        fontFamily: fontFamily,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        //wordSpacing: 16,
        letterSpacing: 0.5,
        fontFamily: fontFamily,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        //wordSpacing: 16,
        letterSpacing: 0.5,
        fontFamily: fontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        //wordSpacing: 24,
        letterSpacing: 0.15,
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        //wordSpacing: 20,
        letterSpacing: 0.25,
        fontFamily: fontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        //wordSpacing: 16,
        letterSpacing: 0.4,
        fontFamily: fontFamily,
      ),
    );
