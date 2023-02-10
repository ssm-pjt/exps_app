// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalData _$ApprovalDataFromJson(Map<String, dynamic> json) => ApprovalData(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      dept: json['dept'] as String,
      dataList: json['dataList'] as List<dynamic>,
      regDatetime: json['regDatetime'] as String,
      documentDatetime: json['documentDatetime'] as String,
      postingDatetime: json['postingDatetime'] as String?,
      status: json['status'] as String,
      purpose: json['purpose'] as String,
      account: json['account'] as String,
      approvalName: json['approvalName'] as String,
      totalAmount: json['totalAmount'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$ApprovalDataToJson(ApprovalData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'dept': instance.dept,
      'dataList': instance.dataList,
      'regDatetime': instance.regDatetime,
      'documentDatetime': instance.documentDatetime,
      'postingDatetime': instance.postingDatetime,
      'purpose': instance.purpose,
      'account': instance.account,
      'status': instance.status,
      'approvalName': instance.approvalName,
      'totalAmount': instance.totalAmount,
      'type': instance.type,
    };
