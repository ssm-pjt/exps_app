import 'package:exps_app/approval/model/approval_data.dart';
import 'package:exps_app/card/controller/card_list_controller.dart';
import 'package:exps_app/receipt/controller/receipt_list_controller.dart';
import 'package:get/get.dart';

import 'approval_list_controller.dart';

class ApprovalDetailController extends GetxController {

  void approval(ApprovalData data, String yn) {
    if (data.type == 'C') {
      List<ApprovalData> list = Get.find<ApprovalListController>().approvalList;

      for (var i = 0; i < list.length; i++) {
        if (list[i].id == data.id) {
          list[i].status = yn;
        }
      }

      List<dynamic> olist = data.dataList;
      List<dynamic> rlist = Get.find<CardListController>().card_list;

      for (var i = 0; i < olist.length; i++) {
        for (var j = 0; j < rlist.length; j++) {
          if (olist[i].id == rlist[j].id) {
            rlist[j].status = yn;
          }
        }
      }

      Get.find<CardListController>().update();

    } else if (data.type == 'R') {
        List<ApprovalData> list = Get.find<ApprovalListController>().approvalList;

        for (var i = 0; i < list.length; i++) {
          if (list[i].id == data.id) {
            list[i].status = yn;
          }
        }

        List<dynamic> olist = data.dataList;
        List<dynamic> rlist = Get.find<ReceiptListController>().receipt_list;

        for (var i = 0; i < olist.length; i++) {
          for (var j = 0; j < rlist.length; j++) {
            if (olist[i].receiptId == rlist[j].receiptId) {
              rlist[j].status = yn;
            }
          }
        }

        Get.find<ReceiptListController>().update();
    }
    
  }
}
