import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:exps_app/util/date_util.dart';
import 'package:get/get.dart';

class ReceiptWriteController extends GetxController {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  var cardList = ['1234-1234-1234-1234', '5678-5678-5678-5678'];
  var selectedCard = '1234-1234-1234-1234';
  List<Uint8List> imageList = [];

  getImage() {
    return imageList;
  }

  setImage(Uint8List image) {
    imageList.add(image);

    update();
  }

  setImageList(List<String> list) {
    imageList.clear();
    
    for (String item in list) {
      imageList.add(base64Decode(item));
    }
  }

  delImage() {
    imageList.clear();

    update();
  }

  getEncodedImage() {
    List<String> image = [];

    imageList.forEach((element) {
      image.add(base64Encode(element));
    });

    return image;
  }

  getSelectedCard() {
    return selectedCard;
  }

  setSelectedCard(value) {
    this.selectedCard = value;

    update();
  }

  String getStringSelectedDate() {
    return "${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일" +
        ' (${DateUtil.getWeekday(selectedDate.weekday)})';
  }

  void setSelectedDate(DateTime dateTime) {
    this.selectedDate = dateTime;
    update();
  }

  void setSelectedTime(TimeOfDay timeOfDay) {
    this.selectedTime = timeOfDay;
    update();
  }
}
