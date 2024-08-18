import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project2/views/home_view.dart';

import 'login_view.dart';

class RedirectPage extends StatefulWidget {
  const RedirectPage({super.key});

  @override
  State<RedirectPage> createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  @override
  void initState() {
    //todo: handle app updates from here
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        GetStorage getStorage = GetStorage();
        Get.offAll(
          () => (getStorage.hasData("access_token")) ? const HomeView() : const LoginView(),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
