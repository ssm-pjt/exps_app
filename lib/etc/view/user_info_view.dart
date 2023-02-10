import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:exps_app/etc/controller/user_info_controller.dart';
import 'package:exps_app/etc/model/user_info.dart';
import 'package:exps_app/login/controller/login_controller.dart';
import 'package:exps_app/login/view/login_view.dart';
import 'package:get/get.dart';

class UserInfoView extends GetView<UserInfoController> {
  BoxDecoration bx = BoxDecoration(
    color: Colors.white,
  );

  TextEditingController phoneController = TextEditingController();
  TextEditingController prvPasswordController = TextEditingController();
  TextEditingController nxtPasswordController = TextEditingController();
  TextEditingController nxtPasswordValidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    phoneController.text = UserInfoController.phoneNo;
    UserInfo userInfo = controller.getUserInfo();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '내정보',
          ),
          actions: [
          ],
        ),
        body: Container(
                child: GestureDetector(
                onHorizontalDragUpdate: (details){
                  if (details.primaryDelta! > 0) {
                    Get.back();
                    }
                },
          child: CustomScrollView(
            slivers: [
              GetBuilder<UserInfoController>(
                // init: UserInfoController(),
                builder: (_) => SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleContainer('계정정보'),
                        container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(width: 80.0, child: Text("성명")),
                              Container(child: Text("${userInfo.name}")),
                            ],
                          ),
                        ),
                        container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(width: 80.0, child: Text("부서명")),
                              Container(child: Text("${userInfo.dept}")),
                            ],
                          ),
                        ),
                        container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(width: 80.0, child: Text("이메일")),
                              Container(child: Text('${userInfo.email}')),
                            ],
                          ),
                        ),
                        container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(width: 80.0, child: Text("휴대폰")),
                              Container(
                                  child: Text('${UserInfoController.phoneNo}')),
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                            height: 55,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent,
                              ),
                              onPressed: () {
                                Get.defaultDialog(
                                  title: '패스워드 변경',

                                  content: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 5.0,
                                        ),
                                        child: TextFormField(
                                          maxLength: 24,
                                          obscureText: true,
                                          keyboardType: TextInputType.visiblePassword,
                                          controller: prvPasswordController,
                                          onTap: () {},
                                          maxLines: 1,
                                          // maxLength: 13,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: "현재 패스워드",
                                            labelText: "현재 패스워드",
                                            fillColor: Colors.grey.shade100,
                                            filled: true,
                                            // prefixIcon: Icon(Icons.person),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                5.0, 0.0, 5.0, 0.0),

                                            // hintText: "id",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(0.0),
                                                borderSide: BorderSide(
                                                  width: 1.3,
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(0.0),
                                                borderSide: BorderSide(
                                                  width: 1.3,
                                                  color: Colors.black26,
                                                )),
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(0.0),
                                                borderSide: BorderSide(
                                                  width: 0.7,
                                                  color: Colors.black26,
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(0.0),
                                                borderSide: BorderSide(
                                                  width: 1.3,
                                                  color: Colors.black26,
                                                )),
                                            // icon: Icon(Icons.phone),
                                            // labelText: 'cellular phone',
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 5.0,
                                        ),
                                        child: TextFormField(
                                          maxLength: 24,
                                          obscureText: true,
                                          keyboardType: TextInputType.visiblePassword,
                                          controller: nxtPasswordController,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: "신규 패스워드",
                                            labelText: "신규 패스워드",
                                            fillColor: Colors.grey.shade100,
                                            filled: true,
                                            // prefixIcon: Icon(Icons.person),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                5.0, 0.0, 5.0, 0.0),

                                            // hintText: "id",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(0.0),
                                                borderSide: BorderSide(
                                                  width: 1.3,
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(0.0),
                                                borderSide: BorderSide(
                                                  width: 1.3,
                                                  color: Colors.black26,
                                                )),
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(0.0),
                                                borderSide: BorderSide(
                                                  width: 0.7,
                                                  color: Colors.black26,
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(0.0),
                                                borderSide: BorderSide(
                                                  width: 1.3,
                                                  color: Colors.black26,
                                                )),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 5.0,
                                        ),
                                        child: TextFormField(
                                          maxLength: 24,
                                          obscureText: true,
                                          keyboardType: TextInputType.visiblePassword,
                                          controller: nxtPasswordValidController,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: "신규 패스워드 확인",
                                            labelText: "신규 패스워드 확인",
                                            fillColor: Colors.grey.shade100,
                                            filled: true,
                                            // prefixIcon: Icon(Icons.person),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                5.0, 0.0, 5.0, 0.0),

                                            // hintText: "id",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(0.0),
                                                borderSide: BorderSide(
                                                  width: 1.3,
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(0.0),
                                                borderSide: BorderSide(
                                                  width: 1.3,
                                                  color: Colors.black26,
                                                )),
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(0.0),
                                                borderSide: BorderSide(
                                                  width: 0.7,
                                                  color: Colors.black26,
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(0.0),
                                                borderSide: BorderSide(
                                                  width: 1.3,
                                                  color: Colors.black26,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  confirm: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.redAccent,
                                    ),
                                      onPressed: () {
                                        if (nxtPasswordController.value != nxtPasswordValidController.value) {
                                          Get.snackbar('알림', '신규 패스워드가 일치하지 않습니다');
                                          return;
                                        }
                                        Get.back();
                                      },
                                      child: Text('변경')
                                  ),
                                  cancel: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.redAccent,
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('취소')
                                  ),
                                );
                              },
                              child: Text(
                                '패스워드변경',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            )),
                        Divider(),
                        titleContainer('푸시알람'),
                        container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('수신여부'),
                              Switch(
                                activeColor: Theme.of(context).primaryColor,
                                onChanged: (value) {
                                  controller.push = !controller.push;
                                  controller.update();
                                },
                                value: controller.push,
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        // Material(
                        //   color: Colors.transparent,
                        //   child: InkWell(
                        //     onTap: () {
                        //       Get.find<LoginController>().progress.value =
                        //           false;
                        //       Get.to(() => LoginView());
                        //     },
                        //     child: ListTile(
                        //       iconColor: Colors.deepPurple,
                        //       leading: Icon(Icons.logout),
                        //       title: Text("로그아웃")),
                        //   ),
                        // )
                      ],
                    )
                  ]),
                ),
              )
            ],
          ),
                )
        ));
  }

  Container container({required Row child}) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(15, 2, 15, 4),
      color: Colors.white,
      child: child,
    );
  }

  Container titleContainer(String text) {
    return Container(
        margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Text(text,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)));
  }
}
