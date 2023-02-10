import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exps_app/approval/controller/approval_list_controller.dart';
import 'package:exps_app/etc/controller/etc_list_controller.dart';
import 'package:exps_app/home/controller/home_controller.dart';
import 'package:exps_app/login/controller/login_controller.dart';
import 'package:exps_app/main/view/main_view.dart';
import 'package:exps_app/receipt/controller/receipt_list_controller.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());

    return Scaffold(body: Obx(() {
      if (controller.progress.isFalse) {
        return login(context, controller);
      } else {
        return Center(
          child: Container(
              width: 100,
              height: 100,
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator()),
        );
      }
    }));
  }

  Widget login(context, controller) {
    return GetBuilder<LoginController>(
      builder: (_) => SingleChildScrollView(
        controller: _.scrollController,
        child: Container(
          height: MediaQuery.of(context).size.height * 1.2,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                  child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(15.0),
                    // border: Border.all(width: 1.0, color: Colors.black),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.1),
                    //     spreadRadius: 1,
                    //     blurRadius: 1,
                    //     offset: Offset(0, 2), // changes position of shadow
                    //   ),
                    // ],
                    ),
                child: Image.asset(
                  'assets/img/logo_test.png',
                  fit: BoxFit.fill,
                  width: 250,
                ),
              )),
              SizedBox(height: 100.0),
              Container(child: userForm(context, controller)),
              SizedBox(height: 20.0),
              Container(child: passwordForm(context, controller)),
              SizedBox(height: 7.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  autologin(context, controller),
                  forgetPassword(context, controller),
                ],
              ),
              SizedBox(height: 30.0),
              GetBuilder<LoginController>(
                builder: (_) => Container(
                  child: loginButton(context, controller),
                ),
              ),
              // Text(tr('signUp')),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField userForm(context, controller) {
    return TextFormField(
      onTap: () {
        controller.scrollController.animateTo(140.0,
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
      },
      obscureText: false,
      style: TextStyle(fontSize: 17.0),
      controller: controller.idController,
      keyboardType: TextInputType.name,
      maxLength: 24,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
      ], // Only numbers can be entered
      decoration: InputDecoration(
          counterText: '',
          fillColor: Colors.grey.shade100,
          filled: true,
          prefixIcon: Icon(
            Icons.person,
          ),
          prefixIconColor: Colors.deepPurple,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: tr("id"),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                width: 2,
                color: Colors.black.withOpacity(0.5),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                width: 2,
                color: Colors.black,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                style: BorderStyle.none,
                width: 0.0,
                color: Colors.white,
              ))),
      validator: (value) {},
    );
  }

  TextFormField passwordForm(context, controller) {
    return TextFormField(
      obscureText: controller.hidePassword.value,
      style: TextStyle(fontSize: 17.0),
      controller: controller.passController,
      keyboardType: TextInputType.visiblePassword,
      maxLength: 48,
      decoration: InputDecoration(
          counterText: '',
          fillColor: Colors.grey.shade100,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: controller.hidePassword.value
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
            color: Colors.black.withOpacity(0.7),
            onPressed: () {
              controller.hidePassword.value = !controller.hidePassword.value;
              controller.update();
            },
          ),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: tr('password'),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                width: 2,
                color: Colors.black.withOpacity(0.5),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                width: 2,
                color: Colors.black,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          )),
      validator: (value) {},
    );
  }

  AnimatedContainer loginButton(context, controller) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 40),
      width: MediaQuery.of(context).size.width * 0.3,
      transform: controller.valid.value
          ? Matrix4.rotationY(0.3)
          : Matrix4.rotationY(-0.3),
      transformAlignment:
          controller.valid.value ? Alignment.centerLeft : Alignment.centerRight,
      curve: Curves.fastOutSlowIn,
      color: Colors.transparent,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black.withOpacity(0.6),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width * 0.2,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            if (controller.idController.value.text.length == 0) {
              Get.snackbar(tr('notice'), tr('message.inputId'));
              HapticFeedback.vibrate();

              for (int i = 0; i < 40; i++) {
                await Future.delayed(Duration(milliseconds: 40), () {
                  controller.valid.value = !controller.valid.value;
                  controller.update();
                });
              }

              return;
            }

            if (controller.passController.value.text.length == 0) {
              Get.snackbar(
                tr('notice'),
                tr('message.inputPassword'),
                // backgroundColor: Colors.white.withOpacity(0.3)
              );

              // var snackBar = SnackBar(
              //   content: Text('Yay! A SnackBar!'),
              // );

              // // Find the ScaffoldMessenger in the widget tree
              // // and use it to show a SnackBar.
              // ScaffoldMessenger.of(context).showSnackBar(snackBar);

              HapticFeedback.vibrate();

              for (int i = 0; i < 40; i++) {
                await Future.delayed(Duration(milliseconds: 40), () {
                  controller.valid.value = !controller.valid.value;
                  controller.update();
                });
              }

              return;
            }

            controller.login();
            controller.progress.value = true;

            Future.delayed(const Duration(milliseconds: 500), () {
              Get.offAll(() => MainView(), );
            });

            Get.put(ReceiptListController());
            Get.put(EtcListController());
            Get.put(ApprovalListController());
            Get.put(HomeController()).loadData();
          },
          child: Text(tr("signIn"),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              )),
        ),
      ),
    );
  }

  Widget autologin(context, controller) {
    return Row(
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (value) {
            controller.autologin.value = value;
            controller.update();
          },
          value: controller.autologin.value,
        ),
        InkWell(
            onTap: () {
              controller.autologin.value = !controller.autologin.value;
              controller.update();
            },
            child: Text(tr('autologin'))),
      ],
    );
  }

  Widget forgetPassword(context, controller) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            isDismissible: true,
            enableDrag: true,
            clipBehavior: Clip.antiAlias,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Center(
                                child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade600,
                              borderRadius: BorderRadius.circular(10)),
                        ))),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text('패스워드 찾기'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: false,
                        style: TextStyle(fontSize: 14.0),
                        keyboardType: TextInputType.text,
                        maxLength: 100,
                        inputFormatters: <
                            TextInputFormatter>[], // Only numbers can be entered
                        decoration: InputDecoration(
                            counterText: '',
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: '성명',
                            focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.black.withOpacity(0.5),
                                )),
                            enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.black,
                                )),
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                  width: 0.0,
                                  color: Colors.white,
                                ))),
                        validator: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: false,
                        style: TextStyle(fontSize: 14.0),
                        keyboardType: TextInputType.text,
                        maxLength: 100,
                        inputFormatters: <
                            TextInputFormatter>[], // Only numbers can be entered
                        decoration: InputDecoration(
                            counterText: '',
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: '사번',
                            focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.black.withOpacity(0.5),
                                )),
                            enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.black,
                                )),
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                  width: 0.0,
                                  color: Colors.white,
                                ))),
                        validator: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: false,
                        style: TextStyle(fontSize: 14.0),
                        keyboardType: TextInputType.text,
                        maxLength: 100,
                        inputFormatters: <
                            TextInputFormatter>[], // Only numbers can be entered
                        decoration: InputDecoration(
                            counterText: '',
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: '휴대폰번호',
                            focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.black.withOpacity(0.5),
                                )),
                            enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.black,
                                )),
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                  width: 0.0,
                                  color: Colors.white,
                                ))),
                        validator: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          child: Text('제출'),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('''
- 제출 후 초기화된 패스워드가 이메일이나 휴대폰으로 전송됩니다

- 재 로그인 후 반드시 패스워드를 변경하시기 바랍니다

- 패스워드를 받지 못하신 경우 관련부서에 문의하세요 
  tel) 02-1234-5678
  mail) @email
                    '''),
                    )
                  ],
                ),
              );
            });
      },
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 5.0),
        child: Text(
          tr('message.forgetPassword'),
          style: TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}
