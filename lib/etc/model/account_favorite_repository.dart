import 'account_favorite.dart';

class AccountFavoriteRepository {
  List<AccountFavorite> getAccountFavoriteList() {
    List<AccountFavorite> list = [];

    list.add(AccountFavorite(id: "00001", name: "교통비", useYn: true));
    list.add(AccountFavorite(id: "00002", name: "대외활동비", useYn: true));
    list.add(AccountFavorite(id: "00003", name: "식비", useYn: true));
    list.add(AccountFavorite(id: "00004", name: "교육비", useYn: true));
    list.add(AccountFavorite(id: "00005", name: "소모품비", useYn: true));
    list.add(AccountFavorite(id: "00006", name: "잡비", useYn: false));

    return list;
  }
}
