import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exps_app/card/controller/card_list_controller.dart';
import 'package:exps_app/card/controller/card_write_controller.dart';
import 'package:exps_app/card/model/card_data.dart';
import 'package:exps_app/receipt/controller/receipt_list_controller.dart';
import 'package:exps_app/receipt/controller/receipt_write_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';

import '../../main/view/main_view.dart';

class CardWrite extends GetView<CardWriteController> {
  CardWrite({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final currentDate = DateTime.now();
  final selectedTime = TimeOfDay.now();

  final _merchantFormKey = GlobalKey<FormState>();
  final _merchantTextController = TextEditingController();

  final _merchantAddressFormKey = GlobalKey<FormState>();
  final _merchantAddressTextController = TextEditingController();

  final _companyNoFormKey = GlobalKey<FormState>();
  final _companyNoTextController = TextEditingController();

  final _apprNoFormKey = GlobalKey<FormState>();
  final _apprNoTextController = TextEditingController();

  final _amountFormKey = GlobalKey<FormState>();
  final _amountTextController = TextEditingController();

  final _valueOfSupplyFormKey = GlobalKey<FormState>();
  final _valueOfSupplyController = TextEditingController();

  final _vatFormKey = GlobalKey<FormState>();
  final _vatController = TextEditingController();

  final _serviceFormKey = GlobalKey<FormState>();
  final _serviceController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  late String id;

  bool update = false;

  int index = 0;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ReceiptWriteController());

    //수정건일경우
    if (Get.arguments != null && Get.arguments['index'] != null) {
      index = Get.arguments['index'];
      CardData data = Get.find<CardListController>().card_list[index];
      controller = Get.put(ReceiptWriteController());

      //사용일자
      int year = int.parse(data.apprDt.substring(0, 4));
      int month = int.parse(data.apprDt.substring(4, 6));
      int day = int.parse(data.apprDt.substring(6, 8));

      controller.selectedDate = DateTime(year = year, month = month, day = day);

      //사용시간
      int hour = int.parse(data.apprTm.substring(0, 2));
      int minute = int.parse(data.apprTm.substring(2, 4));

      controller.selectedTime = TimeOfDay(hour: hour, minute: minute);

      //카드번호
      controller.selectedCard = data.cardNo ?? '';

      //가맹점명
      _merchantTextController.text = data.merchant ?? '';

      //가맹점주소
      _merchantAddressTextController.text = data.merchantAddr ?? ' ';

      //사업자번호
      _companyNoTextController.text = data.companyNo ?? ' ';

      //승인번호
      _apprNoTextController.text = data.apprNo ?? '';

      //사용금액
      _amountTextController.text =
          data.apprTot == null ? '' : data.apprTot.toString();

      //공급가액
      _valueOfSupplyController.text =
          data.apprAmt == null ? '' : data.apprAmt.toString();

      //부가세
      if (data.vat == null) {
        _vatController.text = '0';
      } else {
        _vatController.text = data.vat.toString();
      }

      //봉사료
      if (data.serviceCharge == null) {
        _serviceController.text = '0';
      } else {
        _serviceController.text = data.serviceCharge.toString();
      }

      //증빙자료
      if (data.image != null && data.image!.length != 0) {
        controller.imageList.add(base64Decode(data.image!));
      }

      update = true;

      id = data.id;
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '영수증 등록',
          ),
          actions: [
            TextButton(
              onPressed: () {
                CardData data = CardData(
                  id: update ? id : Uuid().v4().toString().substring(0, 18),
                  userId: 'TESTUSER',
                  cardNo: controller.selectedCard,
                  apprNo: _apprNoTextController.value.text,
                  apprDt: sprintf("%02d%02d%02d", [
                    controller.selectedDate.year,
                    controller.selectedDate.month,
                    controller.selectedDate.day
                  ]),
                  apprTm: sprintf("%02d%02d00", [
                    controller.selectedTime.hour,
                    controller.selectedTime.minute
                  ]),
                  apprTot: num.parse(_amountTextController.value.text),
                  merchant: _merchantTextController.value.text,
                  merchantAddr: _merchantAddressTextController.value.text,
                  type: "R",
                  status: "U",
                  companyNo: _companyNoTextController.value.text,
                  apprAmt: num.parse(_valueOfSupplyController.value.text),
                  vat: num.parse(_vatController.value.text),
                  serviceCharge: num.parse(_serviceController.value.text),
                  image: controller.imageList.length == 0
                      ? null
                      : base64Encode(controller.imageList[0]),
                );

                if (update) {
                  int index =
                      Get.find<ReceiptListController>().findIndexById(data.id);
                  Get.find<CardListController>().card_list.removeAt(index);
                  Get.find<CardListController>().card_list.insert(index, data);
                } else {
                  Get.find<CardListController>().card_list.insert(0, data);
                }
                

                Get.find<ReceiptListController>().update();
                Get.offAll(
                  () => MainView(),
                  arguments: {'page': 1},
                  transition: Transition.upToDown,
                );
              },
              child: Text(
                '등록',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  width: 1.0,
                  color: Colors.white54,
                )),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: GetBuilder<ReceiptWriteController>(
              builder: (_) => SingleChildScrollView(
                  child: Column(
                children: [
                  oContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('작성자'),
                        getValue("홍길동"),
                      ],
                    ),
                  ),
                  eContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('소속부서'),
                        getValue("운영부"),
                      ],
                    ),
                  ),
                  oContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('등록번호'),
                        getValue('R0000000001'),
                      ],
                    ),
                  ),
                  // eContainer(
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       getTitle('사용일자'),
                  //       Expanded(
                  //         child: TextFormField(
                  //           enabled: true,
                  //           autocorrect: false,
                  //           maxLines: 1,
                  //           initialValue: _.getStringSelectedDate(),
                  //           onTap: () {
                  //             _selectDate(context);
                  //           },
                  //         )
                  //       )
                  //     ],
                  //   )
                  // ),
                  eContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('사용일자'),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: getValue(_.getStringSelectedDate()),
                              ),
                              TextButton(
                                  onPressed: () => _selectDate(context),
                                  child: Text(
                                    '변경',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  oContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('사용시간'),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getValue(
                                  '${_.selectedTime.hour}시 ${_.selectedTime.minute}분'),
                              TextButton(
                                  onPressed: () => _selectTime(context),
                                  child: Text('변경',
                                      style: TextStyle(
                                        fontSize: 13,
                                      ))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  eContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('카드번호'),
                        DropdownButton(
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            elevation: 16,
                            underline: Container(
                              height: 1,
                              color: Colors.black38,
                            ),
                            value: controller.getSelectedCard(),
                            items: controller.cardList.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              controller.setSelectedCard(newValue);
                            })
                      ],
                    ),
                  ),
                  oContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('가맹점명'),
                        Expanded(
                          child: TextFormField(
                            key: _merchantFormKey,
                            controller: _merchantTextController,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            maxLength: 30,
                            maxLines: 1,
                            // decoration: InputDecoration(
                            //   border: OutlineInputBorder(),
                            // ),
                          ),
                        )
                      ],
                    ),
                  ),
                  eContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('가맹점주소'),
                        Expanded(
                          child: TextFormField(
                            key: _merchantAddressFormKey,
                            controller: _merchantAddressTextController,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            maxLength: 100,
                            maxLines: 1,
                            // decoration: InputDecoration(
                            //   border: OutlineInputBorder(),
                            // ),
                          ),
                        )
                      ],
                    ),
                  ),
                  oContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('사업자번호'),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            // key: _merchantAddressFormKey,
                            controller: _companyNoTextController,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            maxLength: 10,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                  eContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('승인번호'),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            key: _apprNoFormKey,
                            controller: _apprNoTextController,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            maxLength: 10,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                  oContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('사용금액'),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            key: _amountFormKey,
                            controller: _amountTextController,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            maxLength: 10,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                  eContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('공급가액'),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            key: _valueOfSupplyFormKey,
                            controller: _valueOfSupplyController,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            maxLength: 10,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                  oContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('부가세'),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            key: _vatFormKey,
                            controller: _vatController,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            maxLength: 10,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                  eContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('봉사료'),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            key: _serviceFormKey,
                            controller: _serviceController,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            maxLength: 10,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                  oContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTitle('첨부'),
                        TextButton(
                          onPressed: () {
                            this.getImage(ImageSource.camera);
                          },
                          child: Text("첨부하기 (${controller.imageList.length})"),
                        )
                        // controller.imageList.length == 0 ?
                        //   TextButton(
                        //     onPressed: () {
                        //       this.getImage(ImageSource.camera);
                        //     },
                        //     child: Text("첨부하기"),
                        //   )
                        // :
                        // TextButton(
                        //   onPressed: () {
                        //     controller.delImage();
                        //   },
                        //   child: Text("삭제하기"),
                        // )  ,
                      ],
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: GridView.builder(
                          shrinkWrap: false,
                          primary: false,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1),
                          itemCount: controller.imageList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(15)),
                              child: GestureDetector(
                                  onLongPress: () {
                                    Get.dialog(
                                      AlertDialog(
                                        title: Text('알림'),
                                        content: Text('삭제하시겠습니까?'),
                                        actions: [
                                          TextButton(
                                            child: Text('예'),
                                            onPressed: () {
                                              controller.imageList
                                                  .removeAt(index);
                                              controller.update();
                                              Get.back();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('아니오'),
                                            onPressed: () {
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
                                    //( context: context,
                                    //   builder: (context) => AlertDialog( title: Text('Do you want to exit?'),
                                    //     actions: <Widget>[ FlatButton( child: Text('No'),
                                    //       onPressed: () => Navigator.pop(context),
                                    //     ), FlatButton( child: Text('Yes'),
                                    //       onPressed: () => SystemNavigator.pop(),
                                    //     ),
                                    //     ],
                                    // ));
                                  },
                                  child: Image.memory(
                                      controller.imageList[index])),
                            );
                          })),
                ],
              )),
            )));
  }

  Container eContainer(Row row) {
    var controller = Get.put(ReceiptWriteController());

    return Container(
      padding: EdgeInsets.all(3),
      color: Colors.white,
      child: row,
    );
  }

  Container oContainer(Row row) {
    var controller = Get.put(ReceiptWriteController());

    return Container(
      padding: EdgeInsets.all(3),
      color: Colors.grey.shade100,
      child: row,
    );
  }

  Container getTitle(String str) {
    return Container(
      width: 110,
      padding: EdgeInsets.all(5),
      // decoration: BoxDecoration(
      //   border: Border.all(width: 0.0),
      // ),
      child: Text(
        str,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container getValue(String str) {
    if (str == null) {
      str = '';
    }
    return Container(
      padding: EdgeInsets.all(5),
      // decoration: BoxDecoration(
      //   border: Border.all(width: 0.0),
      // ),
      child: Text(
        str,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1));

    dev.log(pickedDate.toString());
    print(pickedDate.toString());

    if (pickedDate != null && pickedDate != currentDate) {
      Get.put(ReceiptWriteController()).setSelectedDate(pickedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    try {
      final TimeOfDay? timeOfDay = await showTimePicker(
          context: context,
          initialTime: selectedTime,
          initialEntryMode: TimePickerEntryMode.input);

      dev.log(timeOfDay.toString());
      if (timeOfDay != null && timeOfDay != selectedTime) {
        Get.put(ReceiptWriteController()).setSelectedTime(timeOfDay);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getImage(ImageSource imageSource) async {
    XFile? xfile = await _picker.pickImage(source: imageSource);
    var controller = Get.put(ReceiptWriteController());

    if (xfile != null) {
      Uint8List list = File(xfile.path).readAsBytesSync();
      controller.setImage(list);
    }
  }
}
