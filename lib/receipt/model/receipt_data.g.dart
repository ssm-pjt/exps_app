// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptData _$ReceiptDataFromJson(Map<String, dynamic> json) => ReceiptData(
      receiptId: json['receiptId'] as String,
      userId: json['userId'] as String,
      apprTot: json['apprTot'] as num,
      apprDt: json['apprDt'] as String,
      type: json['type'] as String,
      account: json['account'] as String,
      image: (json['image'] as List<dynamic>).map((e) => e as String).toList(),
      status: json['status'] as String,
      comment: json['comment'] as String,
    )..select = json['select'] as bool;

Map<String, dynamic> _$ReceiptDataToJson(ReceiptData instance) =>
    <String, dynamic>{
      'receiptId': instance.receiptId,
      'userId': instance.userId,
      'apprTot': instance.apprTot,
      'apprDt': instance.apprDt,
      'select': instance.select,
      'type': instance.type,
      'account': instance.account,
      'image': instance.image,
      'status': instance.status,
      'comment': instance.comment,
    };
