import 'package:exps_app/util/date_util.dart';
import 'package:exps_app/util/string_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card_data.g.dart';

@JsonSerializable()
class CardData {
  CardData({
    required this.id,
    required this.userId,
    this.cardNo,
    required this.apprNo,
    required this.apprTot,
    this.apprAmt,
    this.vat,
    this.serviceCharge,
    required this.apprDt,
    required this.apprTm,
    required this.merchant,
    required this.merchantAddr,
    required this.type,
    this.companyNo,
    this.image,
    required this.status,
  });

  String id;
  String userId; //아이디
  String? cardNo; //카드번호
  String? apprNo; //승인번호
  num apprTot; //결제금액
  num? apprAmt; //승인금액
  num? vat; //부가세
  num? serviceCharge; //봉사료
  String apprDt; //승인일자
  String apprTm; //승인시간
  String? merchant; //가맹점
  String? merchantAddr; //가맹점주소
  bool select = false;
  String type; //타입 (A:법인카드,B:영수증);
  String? companyNo; //사업자번호
  String? image; //증빙자료
  String status; //상태 (U:미처리, R:진행중, Y:완료, N:반려)

  factory CardData.fromJson(Map<String, dynamic> json) =>
      _$CardDataFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CardDataToJson(this);

  String getStringApprAmt() {
    return getAmt(this.apprAmt);
  }

  String getStringApprTot() {
    return getAmt(this.apprTot);
  }

  String getStringVat() {
    return getAmt(this.vat);
  }

  String getStringServiceCharge() {
    return getAmt(this.serviceCharge);
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
    var time = StringUtil.getStringTime(apprTm);
    // DateFormat("y-MM-dd").p
    return '$str (${weekday})  $time';
  }

  String getApprDateTime() {
    String str =  this.apprDt.substring(0, 4) +
        '-' +
        this.apprDt.substring(4, 6) +
        '-' +
        this.apprDt.substring(6) +
        '';

    DateTime aa = DateTime.parse(str);
    var weekday = DateUtil.getWeekday(aa.weekday);
    var time = StringUtil.getStringTime(apprTm);
    // DateFormat("y-MM-dd").p
    return '$str (${weekday})\n$time';
  }

  String getApprDate() {
    String str =  this.apprDt.substring(0, 4) +
        '-' +
        this.apprDt.substring(4, 6) +
        '-' +
        this.apprDt.substring(6) +
        '';

    DateTime aa = DateTime.parse(str);
    var weekday = DateUtil.getWeekday(aa.weekday);
    return '$str (${weekday})';
  }

  String getApprTime() {
    var time = StringUtil.getStringTime(apprTm);
    return '$time';
  }

  String getApprTm() {
    return this.apprTm.substring(0, 2) + ':' + this.apprTm.substring(2, 4);
    // + ':'
    // + this.apprTm.substring(4);
  }

  CardData getCardData() {
    return this;
  }
}
