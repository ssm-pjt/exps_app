import 'package:flutter/material.dart';

class CardInfo {
  CardInfo({
    required this.cardNo,
    required this.userId,
    required this.cardCompanyName,
    required this.cardCompanyCode,
    required this.color,
    this.image
  });

  String cardNo;
  String userId;
  String cardCompanyName;
  String cardCompanyCode;
  Color color;
  Image? image;
}
