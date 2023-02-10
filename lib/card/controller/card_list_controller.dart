import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:exps_app/card/model/card_data.dart';
import 'package:exps_app/card/model/card_repository.dart';
import 'package:get/get.dart';

class CardListController extends GetxController {
  CardRepository cardRepository = CardRepository();

  List<CardData> card_list = [];
  int a = 0;
  late ScrollController scrollController;
  RxBool fabIsVisible = RxBool(true);

  late DateTime start;
  late DateTime end;

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
  List<CardData> getReceiptList() {
    return card_list.obs;
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
    // List<CardData> itemList = [];
    //
    // if (response.statusCode == 200) {
    //   List list = jsonDecode(utf8.decode(response.bodyBytes));
    //   itemList = list.map((element) => CardData.fromJson(element)).toList();
    // }
    //
    // card_list.clear();
    // card_list = itemList.obs;

    await Future.delayed(Duration(microseconds: 300));

    card_list.clear();
    card_list = cardRepository.getCardList();

    update();
  }

  void setSelect(index) {
    //결재진행중이면 선택불가
    if (card_list[index].status == 'R' || card_list[index].status == 'Y') {
      return;
    }

    if (card_list[index].select) {
      card_list[index].select = false;
    } else {
      card_list[index].select = true;
    }

    update();
  }

  void setUnSelect(index) {
    card_list[index].select = false;

    update();
  }

  Color getColor(index) {
    if (card_list[index].select) {
      return Color(0xfff35a3a).withOpacity(0.7);
    } else {
      return Colors.white;
    }
  }

  bool isSelected(index) {
    return card_list[index].select;
  }

  Icon getIcon(index) {
    // if (card_list[index].select) {
    //   return Icon(Icons.check);
    //
    // } else
    if (card_list[index].type == 'C') {
      return Icon(Icons.credit_card);
    } else if (card_list[index].type == 'R') {
      return Icon(Icons.receipt);
    } else {
      return Icon(Icons.no_accounts);
    }
  }

  void delete(index) {
    var item = card_list[index];
    card_list.removeAt(index);

    update();

    Get.snackbar("영수증",
        "가맹점: ${item.merchant}\n금액: ${item.getStringApprTot()}원 \n\n삭제되었습니다");
  }

  List<CardData> selectedCard() {
    List<CardData> list = [];

    card_list.forEach((element) {
      if (element.select) {
        list.add(element);
      }
    });

    return list;
  }

  String getStringType(index) {
    var type = card_list[index].type;

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
    var status = card_list[index].status;

    switch (status) {
      // case 'U':
      //   return getContainer('미처리', Color(0xffbababa));
      case 'R':
        return getContainer('결재중', Colors.blueGrey);
      case 'Y':
        return getContainer('결재완료', Color(0xff7777cc));
      case 'N':
        return getContainer('반려', Color(0xffcc7777));
      default:
        return getContainer('미처리', Colors.red);
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

    for (int i = 0; i < card_list.length; i++) {
      if (card_list[i].id == id) {
        index = i;
      }
    }

    return index;
  }

  void clearSelected() {
    // card_list.forEach((element) {
    //   element.select = false;
    // });

    for (int i = 0; i < card_list.length; i++) {
      if (card_list[i].select) {
        card_list[i].status = 'R';
      }
      card_list[i].select = false;
    }

    update();
  }

  Widget checkbox(index) {
    if (card_list[index].status == 'Y' || card_list[index].status == 'R') {
      return Theme(
        data: ThemeData(unselectedWidgetColor: Colors.white),
        child: Checkbox(
          onChanged: (bool) {
            
          },
          value: false,
        ),
      );
    } else {
      return Checkbox(
        onChanged: (bool) {
          setSelect(index);
        },
        value: card_list[index].select,
      );
    }
  }

  int count() {
    int cnt = 0;
    card_list.forEach((element) {
      if (element.status == 'U') {
        cnt++;
      }
    });

    return cnt;
  }

  bool edit(index) {
    if (card_list[index].type == 'R' && card_list[index].status == 'U' ||
        card_list[index].status == 'N') {
      return true;
    } else {
      return false;
    }
  }
}
