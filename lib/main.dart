import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project2/controllers/locale_controller.dart';
import 'package:project2/controllers/theme_controller.dart';
import 'package:project2/locale.dart';
import 'package:project2/themes.dart';
import 'package:project2/views/home_view.dart';
import 'package:project2/views/redirect_page.dart';

late CameraDescription camera;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final cameras = await availableCameras();
  camera = cameras.first;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController tC = Get.put(ThemeController());
    return GetBuilder<LocaleController>(
      init: LocaleController(),
      builder: (con) {
        return GetMaterialApp(
          title: 'project2',
          theme: GetStorage().read("lang") == 'ar' ? MyThemes.myLightModeAR : MyThemes.myLightModeEN,
          darkTheme: GetStorage().read("lang") == 'ar' ? MyThemes.myDarkModeAR : MyThemes.myDarkModeEN,
          themeMode: tC.getThemeMode(),
          translations: MyLocale(),
          locale: con.initialLang,
          debugShowCheckedModeBanner: false,
          home: HomeView(),
        );
      },
    );
  }
}
