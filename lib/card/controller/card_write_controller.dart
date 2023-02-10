import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:exps_app/util/date_util.dart';
import 'package:get/get.dart';

class CardWriteController extends GetxController {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  var cardList = ['1234-1234-1234-1234', '5678-5678-5678-5678'];
  var selectedCard= '1234-1234-1234-1234';
  List<Uint8List> imageList = [];

  getImage() {
    return imageList;
  }

  setImage(Uint8List image) {
    imageList.add(image);

    update();
  }

  delImage() {
    imageList.clear();

    update();
  }
  // final CameraDescription camera;

  getSelectedCard() {
    return selectedCard;
  }

  setSelectedCard(value) {
    this.selectedCard = value;

    update();
  }

  String getStringSelectedDate() {
    return "${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일"
    + ' (${DateUtil.getWeekday(selectedDate.weekday)})';
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