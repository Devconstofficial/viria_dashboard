import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:viria_dashboard/screens/auth_screens/login_screen.dart';
import 'package:viria_dashboard/screens/forgot_pass_screen/send_otp_screen.dart';
import 'package:viria_dashboard/screens/forgot_pass_screen/set_new_pass.dart';
import 'package:viria_dashboard/screens/forgot_pass_screen/verify_otp_screen.dart';
import 'package:viria_dashboard/utils/screen_bindings.dart';
import '../screens/dashboard_screen/dashboard_screen.dart';
import '../screens/settings_screen/settings_screen.dart';
import '../screens/subcription_screen/subscription_screen.dart';
import '../screens/subtitle_screen/subtitle_screen.dart';
import '../screens/user_screen/user_screen.dart';
import '../screens/video_screen/videos_screen.dart';
import 'app_strings.dart';

class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(name: kDashboardScreenRoute, page: () => DashboardScreen(), binding: ScreenBindings(),),
      GetPage(name: kUserScreenRoute, page: () => UserScreen(), binding: ScreenBindings(),),
      GetPage(name: kSubscriptionScreenRoute, page: () => SubscriptionScreen(), binding: ScreenBindings(),),
      GetPage(name: kSettingsScreenRouteRoute, page: () => SettingsScreen(), binding: ScreenBindings(),),
      GetPage(name: kSubtitleScreenRouteRoute, page: () => SubtitleScreen(), binding: ScreenBindings(),),
      GetPage(name: kVideoScreenRoute, page: () => VideoScreen(), binding: ScreenBindings(),),
      GetPage(name: kAuthScreenRoute, page: () => LoginScreen(), binding: ScreenBindings(),),
      GetPage(name: kSendOtpScreenRoute, page: () => SendOtpScreen(), binding: ScreenBindings(),),
      GetPage(name: kVerifyOtpScreenRoute, page: () => VerifyOtpScreen(), binding: ScreenBindings(),),
      GetPage(name: kSetNewPassScreenRoute, page: () => SetNewPassScreen(), binding: ScreenBindings(),),
    ];
  }
}

