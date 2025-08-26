import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ForgotController extends GetxController {
  var passwordController = TextEditingController();
  var newPassController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isNewPasswordVisible = false.obs;
}
