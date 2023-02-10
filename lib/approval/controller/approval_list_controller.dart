import 'package:flutter/material.dart';
import 'package:exps_app/approval/model/approval_data.dart';
import 'package:exps_app/card/controller/card_list_controller.dart';
import 'package:exps_app/receipt/controller/receipt_list_controller.dart';
import 'package:exps_app/receipt/model/receipt_data.dart';
import 'package:exps_app/util/string_util.dart';
import 'package:get/get.dart';

class ApprovalListController extends GetxController {
  List<ApprovalData> approvalList = [];
  Rx<Color> tileBackgroundColor = Colors.white.obs;

  String sum(index) {
    ApprovalData data = approvalList[index];

    List<dynamic> dataList = data.dataList;

    num total = 0;
    dataList.forEach((element) {
      total += element.apprTot;
    });

    return StringUtil.getStringAmount(total);
  }

  String getDocumentDate(index) {
    return approvalList[index].documentDatetime;
  }

  void cancel(index) {
    approvalList[index].status = 'C';

    if (approvalList[index].type == 'C') {

      List<dynamic> olist = approvalList[index].dataList;

      List<dynamic> rlist = Get.find<CardListController>().card_list;

      for (var i = 0; i < olist.length; i++) {
        for (var j = 0; j < rlist.length; j++) {
          if (olist[i].id == rlist[j].id) {
            rlist[j].status = 'U';
          }
        }
      }

      Get.find<ReceiptListController>().update();

    } else if (approvalList[index].type == 'R') {
      List<dynamic> olist = approvalList[index].dataList;

      List<dynamic> rlist = Get.find<ReceiptListController>().receipt_list;

      for (var i = 0; i < olist.length; i++) {
        for (var j = 0; j < rlist.length; j++) {
          if (olist[i].receiptId == rlist[j].receiptId) {
            rlist[j].status = 'U';
          }
        }
      }

      Get.find<ReceiptListController>().update();
    }


    update();
  }

  Container statusContainer(index) {
    var msg = '';
    Color color = Color(0xffbababa);

    switch (approvalList[index].status) {
      case 'Y':
        msg = '승인';
        color = Color(0xff7777cc);
        break;
      case 'N':
        msg = '반려';
        color = Color(0xffcc7777);
        break;
      case 'C':
        msg = '취소';
        break;
      case 'R':
        msg = '결재중';
        color = Colors.blueGrey;
        break;
      default:
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        msg,
        style: TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
