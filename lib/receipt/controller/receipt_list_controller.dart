import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:exps_app/receipt/model/receipt_data.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ReceiptListController extends GetxController {
  final String API_URL =
      'http://211.183.67.178:18080/mobile/receipt?userId=testuser';
  List<ReceiptData> receipt_list = [];
  int a = 0;
  late ScrollController scrollController;
  RxBool fabIsVisible = RxBool(true);

  @override
  void onInit() {
    // called immediately after the widget is allocated memory
    listUpdate();
    scrollController = ScrollController();
    scrollController.addListener(() {
      fabIsVisible(scrollController.position.userScrollDirection ==
          ScrollDirection.forward);
          this.update();
    });
    super.onInit();
  }

  /**
   * 영수증 리스트
   */
  List<ReceiptData> getReceiptList() {
    return receipt_list.obs;
  }

  /**
   * 영수증 리스트 가져오기
   */
  void listUpdate() async {
    // Uri uri = Uri.parse(API_URL);
    //
    // final response = await http.get(uri,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json',
    //     });
    //
    // print(utf8.decode(response.bodyBytes));
    //
    // List<ReceiptData> itemList = [];
    //
    // if (response.statusCode == 200) {
    //   List list = jsonDecode(utf8.decode(response.bodyBytes));
    //   itemList = list.map((element) => ReceiptData.fromJson(element)).toList();
    // }
    //
    // receipt_list.clear();
    // receipt_list = itemList.obs;

    await Future.delayed(Duration(microseconds: 300));

    receipt_list.clear();

    Image.asset("assets/img/receipt1.jpg");
    var pic1 = await rootBundle.load("assets/img/receipt1.jpg");
    var pic2 = await rootBundle.load("assets/img/receipt2.jpg");

    List<String> image = [];

    image.add(base64Encode(pic1.buffer.asUint8List()));
    image.add(base64Encode(pic2.buffer.asUint8List()));
    image.add(base64Encode(pic2.buffer.asUint8List()));
    image.add(base64Encode(pic1.buffer.asUint8List()));
    image.add(base64Encode(pic1.buffer.asUint8List()));

    receipt_list.add(new ReceiptData(
      receiptId: Uuid().v4().toString().substring(0, 18),
      apprTot: 50000,
      apprDt: '20220203',
      userId: 'test',
      type: 'R',
      status: 'U',
      account: "교통비",
      comment: '부산 업무협의 출장',
      image: image,
    ));





    receipt_list.add(new ReceiptData(
      receiptId: Uuid().v4().toString().substring(0, 18),
      apprTot: 200000,
      apprDt: '20220201',
      userId: 'test',
      type: 'R',
      status: 'U',
      account: "대외활동비",
      comment: '부서 단합 대회',
      image: image,
    ));

    update();
  }

  void setSelect(index) {
    //결재진행중이면 선택불가
    if (receipt_list[index].status == 'R' ||
        receipt_list[index].status == 'Y') {
      return;
    }

    if (receipt_list[index].select) {
      receipt_list[index].select = false;
    } else {
      receipt_list[index].select = true;
    }

    update();
  }

  void setUnSelect(index) {
    receipt_list[index].select = false;

    update();
  }

  Color getColor(index) {
    if (receipt_list[index].select) {
      return Color(0xeeeeeeee);
    } else {
      return Colors.white;
    }
  }

  Icon getIcon(index) {
    // if (receipt_list[index].select) {
    //   return Icon(Icons.check);
    //
    // } else
    if (receipt_list[index].type == 'C') {
      return Icon(Icons.credit_card);
    } else if (receipt_list[index].type == 'R') {
      return Icon(Icons.receipt);
    } else {
      return Icon(Icons.no_accounts);
    }
  }

  void delete(index) {
    var item = receipt_list[index];
    receipt_list.removeAt(index);

    update();

    Get.snackbar("영수증",
        "계정: ${item.account}\n금액: ${item.getStringApprTot()}원 \n\n삭제되었습니다");
  }

  List<ReceiptData> selectedReceipt() {
    List<ReceiptData> list = [];

    receipt_list.forEach((element) {
      if (element.select) {
        list.add(element);
      }
    });

    return list;
  }

  String getStringType(index) {
    var type = receipt_list[index].type;

    switch (type) {
      case 'C':
        return '법인카드';
      case 'R':
        return '영수증';
      default:
        return '';
    }
  }

  Container getStatusContainer(index) {
    var status = receipt_list[index].status;

    switch (status) {
      case 'U':
        // return getContainer('미처리', Color(0xffbababa));
        return Container();
      case 'R':
        return getContainer('결재중', Colors.blueGrey);
      case 'Y':
        return getContainer('결재완료', Color(0xff7777cc));
      case 'N':
        return getContainer('반려', Color(0xffcc7777));
      default:
        return Container();
    }
  }

  Container getContainer(String text, Color color) {
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
        text,
        style: TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }

  int findIndexById(String id) {
    int index = -1;

    for (int i = 0; i < receipt_list.length; i++) {
      if (receipt_list[i].receiptId == id) {
        index = i;
      }
    }

    return index;
  }

  void clearSelected() {

    for (int i = 0; i < receipt_list.length; i++) {
      if (receipt_list[i].select) {
        receipt_list[i].status = 'R';
      }
      
      receipt_list[i].select = false;
    }

    update();
  }

  Widget checkbox(index) {
    if (receipt_list[index].status == 'Y' ||
        receipt_list[index].status == 'R') {
      return Theme(
        data: ThemeData(unselectedWidgetColor: Colors.white),
        child: Checkbox(
          onChanged: (bool) {},
          value: false,
        ),
      );
    } else {
      return Checkbox(
        onChanged: (bool) {
          setSelect(index);
        },
        value: receipt_list[index].select,
      );
    }
  }

  int count() {
    int cnt = 0;
    receipt_list.forEach((element) {
      if (element.status == 'U') {
        cnt++;
      }
    });

    return cnt;
  }

  bool edit(index) {
    if (receipt_list[index].type == 'R' && receipt_list[index].status == 'U' ||
        receipt_list[index].status == 'N') {
      return true;
    } else {
      return false;
    }
  }

  bool isSelectList() {
    bool result = false;

    receipt_list.forEach((element) {
      if(element.select) {
        result = true;
      }
    });

    return result;
  }

}