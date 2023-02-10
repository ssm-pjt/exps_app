import 'package:flutter/material.dart';
import 'package:exps_app/bindings.dart';
import 'package:exps_app/main/view/main_view.dart';
import 'package:exps_app/receipt/controller/receipt_write_controller.dart';
import 'package:exps_app/receipt/view/receipt_write_view.dart';
import 'package:get/get.dart';

import 'etc/controller/account_favorite_controller.dart';
import 'etc/controller/approval_info_controller.dart';
import 'etc/controller/card_info_controller.dart';
import 'etc/controller/priority_info_controller.dart';
import 'etc/controller/user_info_controller.dart';
import 'etc/view/account_favorite_view.dart';
import 'etc/view/approval_info_view.dart';
import 'etc/view/card_info_view.dart';
import 'etc/view/priority_info_view.dart';
import 'etc/view/user_info_view.dart';
import 'notice/view/notice_view.dart';

routePage() {
  return [
    GetPage(name: '/notice', page: () => NoticeView(), transition: Transition.rightToLeftWithFade),
    GetPage(
        name: '/receipt/write',
        page: () => ReceiptWrite(),
        transition: Transition.downToUp,
        binding: BindingsBuilder<ReceiptWriteController>(() {
          Get.lazyPut(() => ReceiptWriteController());
        })),
//내정보
    GetPage(
        name: '/etc/userinfo',
        page: () => UserInfoView(),
        transition: Transition.rightToLeftWithFade,
        binding: BindingsBuilder<UserInfoController>(() {
          Get.lazyPut(() => UserInfoController());
        })),
//결재선지정
    GetPage(
        name: '/etc/approvalinfo',
        page: () => ApprovalInfoView(),
        transition: Transition.rightToLeftWithFade,
        binding: BindingsBuilder<ApprovalInfoController>(() {
          Get.lazyPut(() => ApprovalInfoController());
        })),
//우선순위
    GetPage(
        name: '/etc/priorityinfo',
        page: () => PriorityInfoView(),
        transition: Transition.rightToLeftWithFade,
        binding: BindingsBuilder<PriorityInfoController>(() {
          Get.lazyPut(() => PriorityInfoController());
        })),
//보유카드조회
    GetPage(
        name: '/etc/cardinfo',
        page: () => CardInfoView(),
        transition: Transition.rightToLeftWithFade,
        binding: BindingsBuilder<CardInfoController>(() {
          Get.lazyPut(() => CardInfoController());
        })),
//계정과목 즐겨찾기
    GetPage(
        name: '/etc/accountfavorite',
        page: () => AccountFavoriteView(),
        transition: Transition.rightToLeftWithFade,
        binding: BindingsBuilder<AccountFavoriteController>(() {
          Get.lazyPut(() => AccountFavoriteController());
        })),
  ];
}
