import 'package:flutter/material.dart';
import 'package:exps_app/util/date_util.dart';
import 'package:exps_app/util/string_util.dart';
import 'package:json_annotation/json_annotation.dart';
part 'receipt_data.g.dart';

@JsonSerializable()
class ReceiptData {
  ReceiptData({
    required this.receiptId,
    required this.userId,
    required this.apprTot,
    required this.apprDt,
    required this.type,
    required this.account,
    required this.image,
    required this.status,
    required this.comment,
  });

  String receiptId;
  String userId; //아이디
  num apprTot; //결제금액
  String apprDt; //승인일자
  bool select = false;
  String type; //타입 (A:법인카드,B:영수증);
  String account; //계정
  List<String> image; //증빙자료
  String status; //상태 (U:미처리, R:진행중, Y:완료, N:반려)
  String comment;

  factory ReceiptData.fromJson(Map<String, dynamic> json) =>
      _$ReceiptDataFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ReceiptDataToJson(this);

  String getStringApprTot() {
    return getAmt(this.apprTot);
  }

  String getAmt(num? amount) {
    if (amount == null) {
      return "0";
    }

    String amt = amount.toString().split('').reversed.join();
    String result = "";
    int len = amt.length;

    for (int i = 0; i < amt.length; i++) {
      String a = amt.substring(i, i + 1);
      if (i % 3 == 0 && i != 0) {
        result += ",";
      }

      result += a;
    }

    return result.split('').reversed.join();
  }

  String getApprDt() {
    String str =  this.apprDt.substring(0, 4) +
        '-' +
        this.apprDt.substring(4, 6) +
        '-' +
        this.apprDt.substring(6) +
        '';

    DateTime aa = DateTime.parse(str);
    var weekday = DateUtil.getWeekday(aa.weekday);

    // DateFormat("y-MM-dd").p
    return '$str (${weekday}) ';

  }

  ReceiptData getReceptData() {
    return this;
  }
}
