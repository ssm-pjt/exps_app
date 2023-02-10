import 'package:json_annotation/json_annotation.dart';

part 'approval_data.g.dart';

@JsonSerializable()
class ApprovalData {
  ApprovalData({
    required this.id,
    required this.userId,
    required this.userName,
    required this.dept,
    required this.dataList,
    required this.regDatetime,
    required this.documentDatetime,
    this.postingDatetime,
    required this.status,
    required this.purpose,
    required this.account,
    required this.approvalName,
    required this.totalAmount,
    required this.type,
  });

  String id; // 결재번호
  String userId; // 작성자 ID
  String userName; //작성자명
  String dept; //부서

  List<dynamic> dataList; //영수증 or 법인카드 내역
  String regDatetime; // 작성일자
  String documentDatetime; //증빙일
  String? postingDatetime; //전기일 (증빙일 <= 전기일)
  String purpose; //용도
  String account; //계정
  String status; // 상태 (Y:완료, R:진행중, N:반려, C:결재취소)
  String approvalName; //결재자이름
  String totalAmount; //합계금액
  String type; //C:카드 , R:영수증

  ApprovalData getApprovalData() {
    return this;
  }

  factory ApprovalData.fromJson(Map<String, dynamic> json) =>
      _$ApprovalDataFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ApprovalDataToJson(this);
}
