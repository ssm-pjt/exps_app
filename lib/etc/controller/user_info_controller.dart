
import 'package:exps_app/etc/model/user_info.dart';
import 'package:exps_app/etc/model/user_info_repository.dart';
import 'package:get/get.dart';

class UserInfoController extends GetxController {
  UserInfoRepositry userInfoRepositry = UserInfoRepositry();

  bool phoneEdit = false;
  bool passwordEdit = false;
  bool push = false;

  static String phoneNo = '010-1234-5678';
  String passworld = '';

  UserInfo getUserInfo() {
    return userInfoRepositry.getUserInfo();
  }

}

