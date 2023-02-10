import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exps_app/approval/controller/approval_detail_controller.dart';
import 'package:exps_app/approval/controller/approval_list_controller.dart';
import 'package:exps_app/approval/model/approval_data.dart';
import 'package:exps_app/card/model/card_data.dart';
import 'package:exps_app/card/view/card_detail_view.dart';
import 'package:exps_app/main/controller/main_controller.dart';
import 'package:exps_app/main/view/main_view.dart';
import 'package:exps_app/receipt/model/receipt_data.dart';
import 'package:exps_app/receipt/view/receipt_detail_view.dart';
import 'package:get/get.dart';

class ApprovalDetailView extends GetView<ApprovalDetailController> {
  @override
  Widget build(BuildContext context) {
    ApprovalData data = Get.arguments['data'];

    List<dynamic> dataList = data.dataList;

    ApprovalDetailController controller = Get.put(ApprovalDetailController());

    return Scaffold(
      body: CustomScrollView(
        primary: true,
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            centerTitle: false,
            floating: false,
            title: Text(
              '결재내용',
            ),
            actions: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 1.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                  ),
                  onPressed: () {
                    controller.approval(data, "Y");
                    controller.update();
                    Get.find<ApprovalListController>().update();
                    HapticFeedback.mediumImpact();

                    Get.find<MainController>().selectedIndex = 3;
                    Get.find<MainController>().update();

                    Get.back();
                  },
                  child: Text(
                    '승인',
                    style: TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 1.0),
                child: ElevatedButton(
                  onPressed: () {
                    controller.approval(data, "N");
                    controller.update();
                    Get.find<ApprovalListController>().update();
                    HapticFeedback.mediumImpact();

                    Get.find<MainController>().selectedIndex = 3;
                    Get.find<MainController>().update();
                    Get.back();
                  },
                  child: Text(
                    '반려',
                    style: TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.normal),
                  ),
                ),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        width: 1.0,
                        color: Colors.white54,
                      )),
                  // margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        oContainer(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getTitle('작성자'),
                              getValue(data.userName),
                            ],
                          ),
                        ),
                        eContainer(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getTitle('소속부서'),
                              getValue(data.dept),
                            ],
                          ),
                        ),
                        // oContainer(
                        //   Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       getTitle('결의서번호'),
                        //       getValue(data.id),
                        //     ],
                        //   ),
                        // ),
                        oContainer(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getTitle('결재자성명'),
                              getValue(data.approvalName),
                            ],
                          ),
                        ),
                        eContainer(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getTitle('증빙일자'),
                              getValue(data.documentDatetime)
                            ],
                          ),
                        ),
                        oContainer(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getTitle('계정과목'),
                              getValue(data.account)
                            ],
                          ),
                        ),
                        eContainer(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [getTitle('적요'), getValue(data.purpose)],
                          ),
                        ),
                        oContainer(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getTitle('금액합계'),
                              getValue(data.totalAmount)
                            ],
                          ),
                        ),
                      ])),
              SizedBox(
                height: 20,
              ),
              DottedLine(
                dashColor: Colors.black26,
              ),
              SizedBox(
                height: 20,
              ),
              for (int i = 0; i < dataList.length; i++)
                Card(
                    color: Colors.grey.shade50,
                    margin: EdgeInsets.fromLTRB(20, 00, 20, 20),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1.0,
                        )),
                    child: detailList(data, dataList, i))
            ]),
          ),
        ],
      ),
    );
  }

  Widget detailList(ApprovalData data, List<dynamic> dataList, int index) {
    if (data.type == 'C') {
      return cardList(dataList, index);
    } else if (data.type == 'R') {
      return receiptList(dataList, index);
    } else {
      return Container();
    }
  }

  ListTile cardList(dataList, index) {
    CardData item = dataList[index];

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      trailing: GestureDetector(
          onTap: () {
            Get.to(() => CardDetail(),
                transition: Transition.rightToLeftWithFade,
                arguments: {
                  "data": item,
                });
          },
          child: FittedBox(
              child: Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ))),
      title: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(item.merchant ?? '',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[900]))),
                Container(
                    alignment: Alignment.bottomRight,
                    child: FittedBox(
                        alignment: Alignment.centerRight,
                        child: Text(item.getStringApprTot() + ' 원',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black)))),
              ]),
          Row(
            children: [
              Text(
                item.getApprDt(),
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              // SizedBox(width: 30,),
              // _.getStatusContainer(index),
            ],
          ),
          // line(),
        ],
      ),
    );
  }

  ListTile receiptList(dataList, index) {
    ReceiptData item = dataList[index];

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      trailing: GestureDetector(
          onTap: () {
            Get.to(() => ReceiptDetail(),
                transition: Transition.rightToLeftWithFade,
                arguments: {
                  "data": item,
                });
          },
          child: FittedBox(
              child: Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ))),
      title: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(item.account,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[900]))),
                Container(
                    alignment: Alignment.bottomRight,
                    child: FittedBox(
                        alignment: Alignment.centerRight,
                        child: Text(item.getStringApprTot() + ' 원',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black)))),
              ]),
          Row(
            children: [
              Text(
                item.getApprDt(),
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              // SizedBox(width: 30,),
              // _.getStatusContainer(index),
            ],
          ),
          // line(),
        ],
      ),
    );
  }

  Container eContainer(Row row) {
    // var controller = Get.put(ApprovalWriteController());

    return Container(
      padding: EdgeInsets.all(3),
      color: Colors.white,
      child: row,
    );
  }

  Container oContainer(Row row) {
    // var controller = Get.put(ApprovalWriteController());

    return Container(
      padding: EdgeInsets.all(3),
      color: Colors.grey.shade100,
      child: row,
    );
  }

  Container getTitle(String str) {
    return Container(
      width: 110,
      padding: EdgeInsets.all(5),
      // decoration: BoxDecoration(
      //   border: Border.all(width: 0.0),
      // ),
      child: Text(
        str,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Flexible getValue(String str) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.all(5),
        // decoration: BoxDecoration(
        //   border: Border.all(width: 0.0),
        // ),
        child: Text(
          str,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Container line() {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.black26),
          ),
        ));
  }
}
