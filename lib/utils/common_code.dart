import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viria_dashboard/custom_widgets/custom_snackbar.dart';
import 'package:viria_dashboard/utils/app_colors.dart';
import 'package:viria_dashboard/utils/app_strings.dart';
import 'package:viria_dashboard/web_services/auth_services.dart';

class CommonCode {
  static bool isValidEmail(String email) {
    final regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
      r"[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
      r"(?:\.[a-zA-Z]{2,})+$",
    );
    return regex.hasMatch(email);
  }

  static void show() {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  static void hide() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  Future<void> logout() async {
    try {
      final result = await AuthService().logout();
      if (result == true) {
        Get.offAllNamed(kAuthScreenRoute);
        showCustomSnackbar(
          "LOGOUT",
          "You have been logged out successfully.",
          backgroundColor: kGreenColor2,
        );
      }
    } catch (e) {
      log("Logout error: $e");
    }
  }

  bool isValidPhone(String? inputString, {bool isRequired = false}) {
    bool isInputStringValid = false;

    if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
      isInputStringValid = true;
    }

    if (inputString != null && inputString.isNotEmpty) {
      if (inputString.length > 16 || inputString.length < 6) return false;

      const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';

      final regExp = RegExp(pattern);

      isInputStringValid = regExp.hasMatch(inputString);
    }

    return isInputStringValid;
  }

  static unFocus(BuildContext context) {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  static String mapStyles = jsonEncode([
    {
      "elementType": "geometry",
      "stylers": [
        {"color": "#212121"},
      ],
    },
    {
      "elementType": "labels.icon",
      "stylers": [
        {"visibility": "off"},
      ],
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#757575"},
      ],
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [
        {"color": "#212121"},
      ],
    },
    {
      "featureType": "administrative",
      "elementType": "geometry",
      "stylers": [
        {"color": "#757575"},
      ],
    },
    {
      "featureType": "administrative.country",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#9e9e9e"},
      ],
    },
    {
      "featureType": "administrative.land_parcel",
      "stylers": [
        {"visibility": "off"},
      ],
    },
    {
      "featureType": "administrative.locality",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#bdbdbd"},
      ],
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#757575"},
      ],
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [
        {"color": "#181818"},
      ],
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#616161"},
      ],
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.stroke",
      "stylers": [
        {"color": "#1b1b1b"},
      ],
    },
    {
      "featureType": "road",
      "elementType": "geometry.fill",
      "stylers": [
        {"color": "#2c2c2c"},
      ],
    },
    {
      "featureType": "road",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#8a8a8a"},
      ],
    },
    {
      "featureType": "road.arterial",
      "elementType": "geometry",
      "stylers": [
        {"color": "#373737"},
      ],
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [
        {"color": "#3c3c3c"},
      ],
    },
    {
      "featureType": "road.highway.controlled_access",
      "elementType": "geometry",
      "stylers": [
        {"color": "#4e4e4e"},
      ],
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#616161"},
      ],
    },
    {
      "featureType": "transit",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#757575"},
      ],
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
        {"color": "#000000"},
      ],
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#3d3d3d"},
      ],
    },
  ]);
}
