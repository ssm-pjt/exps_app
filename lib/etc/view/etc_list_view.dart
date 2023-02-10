import 'package:flutter/material.dart';
import 'package:exps_app/etc/controller/etc_list_controller.dart';
import 'package:exps_app/login/controller/login_controller.dart';
import 'package:exps_app/login/view/login_view.dart';
import 'package:exps_app/main/controller/main_controller.dart';
import 'package:get/get.dart';

class EtcListView extends GetView<EtcListController> {
  Icon trailIcon = Icon(
    Icons.arrow_forward_ios,
    size: 18.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(list(context)),
              )
            ],
          ),
        ));
  }

  List<Widget> list(context) {
    return <Widget>[
      Stack(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 35,
                )),
          ),
          Positioned(
              top: 28,
              left: 80,
              child: Text(
                '홍길동',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ))
        ],
      ),
      Divider(height: 15.0, thickness: 15.0, color: Colors.grey.shade200),
      Divider(
        height: 10.0,
        thickness: 10.0,
        color: Colors.white,
      ),
      Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
          child: Text('내정보',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      InkWell(
        onTap: () {
          Get.toNamed("/etc/userinfo");
        },
        child: ListTile(
          tileColor: Colors.white,
          title: Text("나의 정보"),
          leading: Icon(Icons.person),
          trailing: trailIcon,
        ),
      ),
      InkWell(
        onTap: () {
          Get.toNamed("/etc/approvalinfo");
        },
        child: ListTile(
          tileColor: Colors.white,
          title: Text("결재선 지정"),
          leading: Icon(Icons.approval_outlined),
          trailing: trailIcon,
        ),
      ),
      Divider(
        height: 20.0,
        thickness: 20.0,
        color: Colors.white,
      ),
      Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
          child: Text('카드정보',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      InkWell(
        onTap: () {
          Get.toNamed("/etc/cardinfo");
        },
        child: ListTile(
          tileColor: Colors.white,
          title: Text("보유카드 조회"),
          leading: Icon(Icons.credit_card),
          trailing: trailIcon,
        ),
      ),
      Divider(
        height: 20.0,
        thickness: 20.0,
        color: Colors.white,
      ),
      Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
          child: Text('계정정보',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      InkWell(
        onTap: () {
          Get.toNamed("/etc/accountfavorite");
        },
        child: ListTile(
          tileColor: Colors.white,
          title: Text("계정 과목 즐겨찾기"),
          leading: Icon(Icons.star),
          trailing: trailIcon,
        ),
      ),
      Divider(height: 15.0, thickness: 15.0, color: Colors.grey.shade200),
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.find<LoginController>().progress.value = false;
            Get.find<MainController>().selectedIndex = 0;
            Get.offAll(() => LoginView());
          },
          child: ListTile(
            iconColor: Colors.deepPurple,
            leading: Icon(
              Icons.logout,
              size: 20,
            ),
            title: Text("로그아웃", style: TextStyle(fontSize: 14)),
          ),
        ),
      ),
    ];
  }
}
