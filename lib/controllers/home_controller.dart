import 'package:get/get.dart';
import 'package:project2/models/user_model.dart';
import 'package:project2/services/remote_services/logout_service.dart';
import 'package:project2/services/remote_services/my_profile_service.dart';
import 'package:project2/views/login_view.dart';

class HomeController extends GetxController {
  HomeController({logoutService, myProfileService}) {
    _logoutService = logoutService;
    _myProfileService = myProfileService;
  }

  @override
  void onInit() async {
    getCurrentUser();
    super.onInit();
  }

  @override
  void dispose() {
    //
    super.dispose();
  }

  late LogoutService _logoutService;
  late MyProfileService _myProfileService;

  //

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  void getCurrentUser() async {
    // loading indicator
    _currentUser = await _myProfileService.getCurrentUser();
    update();
  }

  //

  void logout() async {
    if (await _logoutService.logout()) {
      Get.offAll(const LoginView());
    } else {
      print("logout failed");
    }
  }
}
