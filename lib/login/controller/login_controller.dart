import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool progress = false.obs;
  RxBool valid = false.obs;
  RxBool hidePassword = true.obs;
  RxBool autologin = false.obs;

  ScrollController scrollController = ScrollController();

  var idController = TextEditingController();
  var passController = TextEditingController();

  login() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool("login", true);
  }

  Future<bool> loginCheck() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool("login") == true) {
      return true;
    } else {
      return false;
    }
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool("login", false);
  }
}
