import 'package:get/get.dart';
import 'package:viria_dashboard/screens/forgot_pass_screen/controller/forgot_pass_controller.dart';
import 'package:viria_dashboard/screens/settings_screen/controller/settings_controller.dart';
import 'package:viria_dashboard/screens/subtitle_screen/controller/subtitle_controller.dart';
import 'package:viria_dashboard/screens/video_screen/controller/video_controller.dart';
import '../screens/auth_screens/controller/auth_controller.dart';
import '../screens/dashboard_screen/controller/dashboard_controller.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => SettingsController());
    Get.lazyPut(() => SubtitleController());
    Get.lazyPut(() => VideoController());
    Get.lazyPut(() => ForgotController());
    Get.lazyPut(() => AuthController());
  }
}
