import 'package:flutter/material.dart';
import 'package:exps_app/card/controller/card_list_controller.dart';
import 'package:exps_app/card/model/card_data.dart';
import 'package:exps_app/receipt/controller/receipt_list_controller.dart';
import 'package:exps_app/receipt/model/receipt_data.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  late PageController pageController;

  int pageIndex = 0;

  num cardCount = 0;
  num cardPendCount = 0;
  num cardProgressCount = 0;
  num cardCompleteCount = 0;
  num cardAmt = 0;
  num receiptCount = 0;
  num receiptPendCount = 0;
  num receiptProgressCount = 0;
  num receiptCompleteCount = 0;
  num receiptAmt = 1;
  num receiptProgressAmt = 0;
  num receiptCompleteAmt = 0;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    pageController = PageController(
      initialPage: pageIndex,
      keepPage: true,
    );

    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    pageController.dispose();
  }

  void loadData() async {
    await Future.delayed(Duration(microseconds: 300));

    List<CardData> card_list = Get.put(CardListController()).card_list;
    List<ReceiptData> receipt_list =
        Get.put(ReceiptListController()).receipt_list;

    cardCount = card_list.length;
    receiptCount = receipt_list.length;

    num cnt = 0;

    card_list.forEach((element) {
      if (element.status == 'U' || element.status == 'N') {
        cnt++;
      }
    });

    cardPendCount = cnt;

    cnt = 0;
    card_list.forEach((element) {
      if (element.status == 'R') {
        cnt++;
      }
    });

    cardProgressCount = cnt;

    cnt = 0;
    card_list.forEach((element) {
      if (element.status == 'Y') {
        cnt++;
      }
    });

    cardCompleteCount = cnt;

    cnt = 0;
    card_list.forEach((element) {
      cnt += element.apprTot;
    });

    cardAmt = cnt;

    cnt = 0;
    receipt_list.forEach((element) {
      if (element.status == 'U'  || element.status == 'N') {
        cnt++;
      }
    });

    receiptPendCount = cnt;

    cnt = 0;
    receipt_list.forEach((element) {
      if (element.status == 'R') {
        cnt++;
      }
    });

    receiptProgressCount = cnt;

    cnt = 0;
    receipt_list.forEach((element) {
      if (element.status == 'Y') {
        cnt++;
      }
    });

    receiptCompleteCount = cnt;

    cnt = 0;
    receipt_list.forEach((element) {
      cnt += element.apprTot;
    });

    receiptAmt = cnt;

    cnt = 0;
    receipt_list.forEach((element) {
      if (element.status == 'R') {
        cnt += element.apprTot;
      }
    });

    receiptProgressAmt = cnt;

    cnt = 0;
    receipt_list.forEach((element) {
      if (element.status == 'Y') {
        cnt += element.apprTot;
      }
    });

    receiptCompleteAmt = cnt;

    update();
  }
}
