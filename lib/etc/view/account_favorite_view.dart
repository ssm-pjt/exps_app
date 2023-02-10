import 'package:flutter/material.dart';
import 'package:exps_app/etc/controller/account_favorite_controller.dart';
import 'package:get/get.dart';

class AccountFavoriteView extends GetView<AccountFavoriteController> {
  @override
  Widget build(BuildContext context) {
    controller.getAccountFavoriteList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '계정정보 즐겨찾기',
        ),
        actions: [
          // TextButton(
          //   child: Icon(Icons.edit, color: Colors.white.withOpacity(0.9)),
          //   onPressed: () {
          //     //개인정보는 서버에
          //   },
          //   // style: TextButton.styleFrom(
          //   //   textStyle: const TextStyle(fontSize: 12),
          //   // ),
          // )
        ],
      ),
      body: GetBuilder<AccountFavoriteController>(
          builder: (_) => ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(thickness: 0.5,);
              },
              itemCount: _.list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  highlightColor: Theme.of(context).primaryColor,
                  onTap: () {
                    int cnt = 0;
                    _.list.forEach((element) {
                      if (element.useYn) {
                        cnt++;
                      }
                    });

                    if (cnt >= 5 && _.list[index].useYn == false) {
                      Get.snackbar('알람', '즐겨찾기는 최대 5개까지 선택 가능합니다');
                      return;
                    }
                    _.list[index].useYn = !_.list[index].useYn;
                    _.update();
                  },
                  child: ListTile(
                    leading: _.list[index].useYn
                        ? Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                          )
                        : Icon(Icons.star_border),
                    title: Text('${_.list[index].name}'),
                  ),
                );
              })),
    );
  }
}
