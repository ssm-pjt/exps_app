// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardData _$CardDataFromJson(Map<String, dynamic> json) => CardData(
      id: json['id'] as String,
      userId: json['userId'] as String,
      cardNo: json['cardNo'] as String?,
      apprNo: json['apprNo'] as String?,
      apprTot: json['apprTot'] as num,
      apprAmt: json['apprAmt'] as num?,
      vat: json['vat'] as num?,
      serviceCharge: json['serviceCharge'] as num?,
      apprDt: json['apprDt'] as String,
      apprTm: json['apprTm'] as String,
      merchant: json['merchant'] as String?,
      merchantAddr: json['merchantAddr'] as String?,
      type: json['type'] as String,
      companyNo: json['companyNo'] as String?,
      image: json['image'] as String?,
      status: json['status'] as String,
    )..select = json['select'] as bool;

Map<String, dynamic> _$CardDataToJson(CardData instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'cardNo': instance.cardNo,
      'apprNo': instance.apprNo,
      'apprTot': instance.apprTot,
      'apprAmt': instance.apprAmt,
      'vat': instance.vat,
      'serviceCharge': instance.serviceCharge,
      'apprDt': instance.apprDt,
      'apprTm': instance.apprTm,
      'merchant': instance.merchant,
      'merchantAddr': instance.merchantAddr,
      'select': instance.select,
      'type': instance.type,
      'companyNo': instance.companyNo,
      'image': instance.image,
      'status': instance.status,
    };
