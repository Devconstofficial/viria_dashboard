import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:viria_dashboard/models/user_model.dart';
import 'package:viria_dashboard/web_services/auth_services.dart';

class SideMenuController extends GetxController {
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
  final AuthService _service = AuthService();
  Timer? _refreshTimer;

  @override
  void onInit() {
    super.onInit();
    startAutoRefreshToken();
  }

  @override
  void onClose() {
    stopAutoRefreshToken();
    super.onClose();
  }

 

  void startAutoRefreshToken() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(minutes: 15), (timer) async {
      try {
        log("Attempting to refresh auth token...");
        final updatedUser = await _service.refreshAuthToken();
        if (updatedUser != null && updatedUser is UserModel) {
          log("Auth token refreshed successfully for ${updatedUser.email}");
        }
      } catch (e) {
        log("Error refreshing auth token: $e");
      }
    });
  }

  void stopAutoRefreshToken() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

}