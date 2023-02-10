import 'package:exps_app/etc/model/account_favorite.dart';
import 'package:exps_app/etc/model/account_favorite_repository.dart';
import 'package:get/get.dart';

class AccountFavoriteController extends GetxController {
  AccountFavoriteRepository accountFavoriteRepository =
      AccountFavoriteRepository();
  List<AccountFavorite> list = [];

  getAccountFavoriteList() {
    list = accountFavoriteRepository.getAccountFavoriteList();
  }
}
