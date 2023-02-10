import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exps_app/etc/model/card_info.dart';
import 'package:get/get.dart';

class CardInfoController extends GetxController {
  PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.85,
  );

  List<CardInfo> cardList = [];

  int viewPageIndex = 0;

  @override
  onInit() {
    cardList = getList();
    super.onInit();
  }

  List<CardInfo> getList() {
    List<CardInfo> cardList = [];

    cardList.add(CardInfo(
        cardNo: '1111-****-****-0000',
        userId: 'id',
        cardCompanyCode: 'HN',
        cardCompanyName: '하나카드',
        color: Colors.white,
        image: Image.asset(
          'assets/img/hana2.png',
          fit: BoxFit.fill,
          scale: 1.0,
        )));

    cardList.add(
      CardInfo(
          cardNo: '2222-****-****-0000',
          userId: 'id',
          cardCompanyCode: 'HN',
          cardCompanyName: '신한카드',
          color: Colors.white,
          image: Image.asset(
            'assets/img/hana2.png',
            fit: BoxFit.fill,
            scale: 1.0,
          )),
    );

    cardList.add(
      CardInfo(
        cardNo: '3333-****-****-0000',
        userId: 'id',
        cardCompanyCode: 'HN',
        cardCompanyName: '국민카드',
        color: Colors.white,
        image: Image.asset(
          'assets/img/hana2.png',
          fit: BoxFit.fill,
          scale: 1.0,
        ),
      ),
    );

    return cardList;
  }
}
