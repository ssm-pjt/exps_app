
import 'package:exps_app/etc/model/user_info.dart';

class UserInfoRepositry {

  UserInfo getUserInfo() {
    //rest로 유저정보 가져온다

    return UserInfo(
      id: 'test',
      name: '홍길동',
      email: '@email',
      phone: '010-1234-5678',
      dept: '운영부');
  }
}