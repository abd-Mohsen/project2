import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/home_controller.dart';
import 'package:project2/controllers/locale_controller.dart';
import 'package:project2/controllers/theme_controller.dart';
import 'package:project2/views/scan_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController hC = Get.put(HomeController());
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
      body: ListView(
        children: [
          // Container(
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage("assets/images/banner.jpg"),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // child: BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          //   child: Container(
          //       //decoration: BoxDecoration(color: Colors.white.withOpacity(1.0)),
          //       ),
          // ),
          //),
          SizedBox(
            height: 100,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Stack(
                children: [
                  Image.asset("assets/images/banner.jpg"),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   //left: 0,
                  //   //right: 0,
                  //   //top: 0,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(20),
                  //     child: Text(
                  //       "welcome",
                  //       style: tt.headlineLarge!.copyWith(color: cs.error, fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(height: 150),

          GestureDetector(
            onTap: () {
              Get.to(ScanView());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: DottedBorder(
                color: cs.secondary,
                dashPattern: [15, 0],
                strokeWidth: 5,
                borderType: BorderType.RRect,
                radius: Radius.circular(20),
                padding: EdgeInsets.all(8),
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
                              "assets/images/scanner.png",
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
        ],
      ),
      drawer: Drawer(
        backgroundColor: cs.background,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      "abd",
                      style: tt.headlineMedium,
                    ),
                    accountEmail: Text(
                      "abd@m.co",
                      style: tt.titleMedium,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.dark_mode_outlined),
                    title: Text("dark mode", style: tt.titleMedium!.copyWith(color: cs.onBackground)),
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
                    title: Text("about app", style: tt.titleMedium!.copyWith(color: cs.onBackground)),
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
                                          "all rights reserved",
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                "all rights reserved",
                style: tt.labelMedium!.copyWith(color: cs.onSurface.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
