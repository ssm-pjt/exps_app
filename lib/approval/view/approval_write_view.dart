import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exps_app/approval/controller/approval_list_controller.dart';
import 'package:exps_app/approval/controller/approval_write_controller.dart';
import 'package:exps_app/approval/model/approval_data.dart';
import 'package:exps_app/card/controller/card_list_controller.dart';
import 'package:exps_app/card/model/card_data.dart';
import 'package:exps_app/main/controller/main_controller.dart';
import 'package:exps_app/receipt/controller/receipt_list_controller.dart';
import 'package:exps_app/util/date_util.dart';
import 'package:exps_app/util/string_util.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../main/view/main_view.dart';

class ApprovalWriteView extends GetView<ApprovalWriteController> {
  ApprovalWriteView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

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

  Container getValue(String str) {
    return Container(
      padding: EdgeInsets.all(5),
      // decoration: BoxDecoration(
      //   border: Border.all(width: 0.0),
      // ),
      child: Text(
        str,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
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

  @override
  Widget build(BuildContext context) {
    List<dynamic> list = Get.arguments['data'];
    num total = 0;

    list.forEach((element) {
      total += element.apprTot;
    });

    String totalAmt = StringUtil.getStringAmount(total);

    var thisdatetime = '${DateTime.now().toString().substring(0, 4)}년 ' +
        '${DateTime.now().toString().substring(5, 7)}월 ' +
        '${DateTime.now().toString().substring(8, 10)}일 ' +
        '(${DateUtil.getWeekday(DateTime.now().weekday)})';

    var controller = Get.put(ApprovalWriteController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '지출결의서 등록',
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.getSelectedValue() == '') {
                Get.snackbar("알림", "계정을 선택하세요");
                return;
              }

              if (_textController.text.length == 0) {
                Get.snackbar("알림", "사용용도를 작성하세요");
                return;
              }

              ApprovalData data = ApprovalData(
                id: Uuid().v4().toString().substring(0, 18),
                userId: "TESTUSER1",
                userName: '홍길동',
                dept: '운영부',
                dataList: list,
                account: controller.getSelectedValue(),
                purpose: _textController.text,
                regDatetime: thisdatetime,
                documentDatetime: thisdatetime,
                status: 'R',
                approvalName: '김영희',
                totalAmount: totalAmt,
                type: list[0].runtimeType == CardData ? 'C' : 'R',
              );

              Get.put(ApprovalListController()).approvalList.insert(0, data);
              Get.find<ApprovalListController>().update();

              if (list[0].runtimeType == CardData) {
                Get.find<CardListController>().clearSelected();
                Get.find<CardListController>().update();
              } else {
                Get.find<ReceiptListController>().clearSelected();
                Get.find<ReceiptListController>().update();
              }

              // Get.find<MainController>().selectedIndex = 3;
              // Get.find<MainController>().scrollController.jumpTo(0);
              // Get.find<MainController>().update();
              Get.back();
            },
            child: Icon(
              Icons.add_box,
              color: Colors.white.withOpacity(0.9),
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              width: 1.0,
              color: Colors.white54,
            )),
        // margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              oContainer(
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [getTitle('증빙일자'), getValue("${thisdatetime}")],
                ),
              ),
              GetBuilder<ApprovalWriteController>(
                builder: (_) => eContainer(Row(
                  children: [
                    getTitle('계정'),
                    Container(
                      child: Row(
                        children: <Widget>[
                          // for (Account acnt in controller.accountList)
                          // Container(
                          //   // margin: EdgeInsets.all(10.0),
                          //   padding: EdgeInsets.symmetric(
                          //     vertical: 2.0,
                          //     horizontal: 4.0
                          //   ),
                          //   decoration: BoxDecoration(
                          //     color: acnt.selected ? Colors.black : Colors.white,
                          //     border: Border.all(
                          //       color: acnt.selected ? Colors.white : Colors.black,
                          //     )
                          //   ),
                          //   child: Text(
                          //       '${acnt.accountName}',
                          //     style: TextStyle(
                          //       color: acnt.selected ? Colors.white : Colors.black,
                          //     ),
                          //   ),
                          // ),
                          getAccountContainer(context, 0),
                          getAccountContainer(context, 1),
                        ],
                      ),
                    )
                  ],
                )),
              ),
              GetBuilder<ApprovalWriteController>(
                builder: (_) => eContainer(Row(
                  children: [
                    getTitle(''),
                    Container(
                      child: Row(
                        children: <Widget>[
                          getAccountContainer(context, 2),
                          getAccountContainer(context, 3),
                          getAccountContainer(context, 4),
                        ],
                      ),
                    )
                  ],
                )),
              ),
              oContainer(Row(
                children: [
                  getTitle('사용용도'),
                  Expanded(
                    child: TextFormField(
                      key: _formKey,
                      controller: _textController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                ],
              )),
              eContainer(
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [getTitle('금액합계'), getValue("${totalAmt}")],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DottedLine(
                dashColor: Colors.black26,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    children: _getList(context, list),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAccountContainer(BuildContext context, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: controller.accountList[index].selected
                ? Theme.of(context).primaryColor
                : Colors.grey,
            width: 0.5,
          )),
      color: controller.accountList[index].selected
          ? Theme.of(context).primaryColor
          : Colors.white,
      child: InkWell(
        onTap: () {
          controller.selectAccount(index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
          // decoration: BoxDecoration(
          //     color: controller.accountList[index].selected ? Theme.of(context).primaryColor : Colors.white,
          //     border: Border.all(
          //       color: controller.accountList[index].selected ? Colors.white : Colors.black,
          //     )
          // ),
          child: Text(
            '${controller.accountList[index].accountName}',
            style: TextStyle(
              fontSize: 12.0,
              color: controller.accountList[index].selected
                  ? Colors.white
                  : Colors.black,
              fontWeight: controller.accountList[index].selected
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getList(BuildContext context, List<dynamic> list) {
    if (list[0].runtimeType == CardData) {
      return _getCardList(context, list);
    } else {
      return _getReceiptList(context, list);
    }
  }

  List<Widget> _getCardList(BuildContext context, List<dynamic> list) {
    List<Card> result = [];
    num no = 1;

    list.forEach((item) {
      Card con = Card(
        color: Colors.grey.shade50,
        margin: EdgeInsets.fromLTRB(00, 00, 0, 10),
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(
              color: Colors.grey.shade400,
              width: 1.0,
            )),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(15.0),
        //     // shape: BoxShape.circle,
        //     border: Border.all(
        //       width: 0.8,
        //       color: Colors.grey.shade400,
        //     )),
        // padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
        // margin: EdgeInsets.fromLTRB(00, 00, 0, 10),
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Positioned(
                top: 7,
                left: 7,
                child: Container(
                    alignment: Alignment.center,
                    // margin: EdgeInsets.all(100.0),
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                        shape: BoxShape.circle),
                    child: Text(
                      '${no++}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))),
            Container(
              padding: EdgeInsets.fromLTRB(50, 10, 20, 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('사용일시'), Text('${item.getApprDt()}')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('카드번호'), Text('${item.cardNo}')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('가맹점명'), Text('${item.merchant}')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('사용금액'),
                      Text('${item.getStringApprTot()} 원')
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      result.add(con);
    });

    return result;
  }

  List<Widget> _getReceiptList(BuildContext context, List<dynamic> list) {
    List<Card> result = [];
    num no = 1;

    list.forEach((item) {
      Card con = Card(
        color: Colors.grey.shade50,
        margin: EdgeInsets.fromLTRB(00, 00, 0, 10),
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(
              color: Colors.grey.shade400,
              width: 1.0,
            )),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(15.0),
        //     // shape: BoxShape.circle,
        //     border: Border.all(
        //       width: 0.8,
        //       color: Colors.grey.shade400,
        //     )),
        // padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
        // margin: EdgeInsets.fromLTRB(00, 00, 0, 10),
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Positioned(
                top: 7,
                left: 7,
                child: Container(
                    alignment: Alignment.center,
                    // margin: EdgeInsets.all(100.0),
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                        shape: BoxShape.circle),
                    child: Text(
                      '${no++}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))),
            Container(
              padding: EdgeInsets.fromLTRB(50, 10, 20, 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('사용일시'), Text('${item.getApprDt()}')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('사용금액'),
                      Text('${item.getStringApprTot()} 원')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('증빙계정'), Text('${item.account}')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('적요'), Text('${item.comment}')],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      result.add(con);
    });

    return result;
  }
}
