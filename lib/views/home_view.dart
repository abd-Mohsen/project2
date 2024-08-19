import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/home_controller.dart';
import 'package:project2/controllers/locale_controller.dart';
import 'package:project2/controllers/theme_controller.dart';
import 'package:project2/services/local_services/exam_selection_service.dart';
import 'package:project2/services/remote_services/logout_service.dart';
import 'package:project2/services/remote_services/my_profile_service.dart';
import 'package:project2/views/exams_view.dart';
import 'package:project2/views/scan_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController hC = Get.put(HomeController(
      logoutService: LogoutService(),
      examSelectionService: ExamSelectionService(),
      myProfileService: MyProfileService(),
    ));
    ThemeController tC = Get.find();
    LocaleController lC = Get.find();
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "project2 💻",
          style: tt.titleLarge!.copyWith(color: cs.onPrimary, fontWeight: FontWeight.bold),
        ),
        backgroundColor: cs.primary,
        centerTitle: true,
      ),
      backgroundColor: cs.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ExamsView());
        },
        child: Icon(Icons.text_snippet),
      ),
      body: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/banner.jpg",
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ),
                ),
                PositionedDirectional(
                  bottom: 0,
                  start: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "welcome",
                          style: tt.headlineLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "enter answers, scan, repeat!",
                          style: tt.headlineSmall!.copyWith(color: Colors.white, shadows: [
                            Shadow(
                              offset: const Offset(3.0, 2.0),
                              blurRadius: 8.0,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => const ScanView());
                  },
                  child: SizedBox(
                    width: 200,
                    child: DottedBorder(
                      color: cs.secondary,
                      dashPattern: const [15, 0],
                      strokeWidth: 2.0,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                    "assets/images/scanner2.png",
                                    color: cs.onBackground,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  "Scan",
                                  style: tt.headlineLarge!.copyWith(color: cs.secondary, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: cs.background,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  GetBuilder<HomeController>(
                    builder: (controller) {
                      return UserAccountsDrawerHeader(
                        accountName: Text(
                          controller.currentUser?.username ?? "loading".tr,
                          style: tt.headlineMedium,
                        ),
                        accountEmail: Text(
                          controller.currentUser?.email ?? "",
                          style: tt.titleMedium,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.dark_mode_outlined),
                    title: Text("dark mode".tr, style: tt.titleMedium!.copyWith(color: cs.onBackground)),
                    trailing: Switch(
                      value: tC.switchValue,
                      onChanged: (bool value) {
                        tC.updateTheme(value);
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.language,
                      //color: cs.onBackground,
                    ),
                    title: DropdownButton(
                      elevation: 50,
                      iconEnabledColor: cs.onBackground,
                      dropdownColor: Get.isDarkMode ? cs.surface : Colors.grey.shade200,
                      hint: Text(
                        lC.getCurrentLanguageLabel(),
                        style: tt.labelLarge!.copyWith(color: cs.onBackground),
                      ),
                      //button label is updating cuz whole app is rebuilt after changing locale
                      items: [
                        DropdownMenuItem(
                          value: "ar",
                          child: Text(
                            "Arabic".tr,
                            style: tt.labelLarge!.copyWith(color: cs.onSurface),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "en",
                          child: Text(
                            "English".tr,
                            style: tt.labelLarge!.copyWith(color: cs.onSurface),
                          ),
                        ),
                      ],
                      onChanged: (val) {
                        lC.updateLocale(val!);
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text("about app".tr, style: tt.titleMedium!.copyWith(color: cs.onBackground)),
                    onTap: () {
                      Get.dialog(
                        AlertDialog(
                          icon: Icon(
                            Icons.info_outline,
                            color: cs.primary,
                            size: 35,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                "ok",
                                style: tt.titleMedium?.copyWith(color: cs.primary),
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
                                          "adadevs© all rights reserved",
                                          style: tt.headlineSmall!.copyWith(color: cs.onSurface),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: cs.error,
                    ),
                    title: Text(
                      "logout".tr,
                      style: tt.titleMedium!.copyWith(color: cs.error),
                    ),
                    onTap: () {
                      hC.logout();
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                "Adadevs© all rights reserved",
                style: tt.labelMedium!.copyWith(color: cs.onSurface.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
