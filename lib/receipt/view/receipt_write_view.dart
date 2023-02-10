import 'dart:developer' as dev;
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exps_app/main/controller/main_controller.dart';
import 'package:exps_app/main/view/main_view.dart';
import 'package:exps_app/receipt/controller/receipt_list_controller.dart';
import 'package:exps_app/receipt/controller/receipt_write_controller.dart';
import 'package:exps_app/receipt/model/receipt_data.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';

class ReceiptWrite extends GetView<ReceiptWriteController> {
  ReceiptWrite({Key? key}) : super(key: key);
  final currentDate = DateTime.now();
  final selectedTime = TimeOfDay.now();
  final _amountFormKey = GlobalKey<FormState>();
  final _amountTextController = TextEditingController();
  final _commentFormKey = GlobalKey<FormState>();
  final _commentTextController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  late String id;

  bool update = false;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ReceiptWriteController());
    String account = "";

    //수정건일경우
    if (Get.arguments != null && Get.arguments['index'] != null) {
      int index = Get.arguments['index'];
      ReceiptData data = Get.find<ReceiptListController>().receipt_list[index];
      controller = Get.put(ReceiptWriteController());

      //사용일자
      int year = int.parse(data.apprDt.substring(0, 4));
      int month = int.parse(data.apprDt.substring(4, 6));
      int day = int.parse(data.apprDt.substring(6, 8));

      controller.selectedDate = DateTime(year = year, month = month, day = day);

      //사용금액
      if (_amountTextController.text.toString().length == 0)
        _amountTextController.text = data.apprTot.toString();

      if (_commentTextController.text.toString().length == 0)
        _commentTextController.text = data.comment;

      account = data.account;

      //증빙자료
      controller.setImageList(data.image);

      update = true;

      id = data.receiptId;
    }

    if (Get.arguments != null && Get.arguments['account'] != null) {
      account = Get.arguments['account'];
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
                if (_amountTextController.value.text.length == 0) {
                  Get.snackbar('알림', '사용금액을 입력하세요');
                  return;
                }

                if (_commentTextController.value.text.length == 0) {
                  Get.snackbar('알림', '적요를 입력하세요');
                  return;
                }

                ReceiptData data = ReceiptData(
                  receiptId:
                      update ? id : Uuid().v4().toString().substring(0, 18),
                  userId: 'TESTUSER',
                  apprDt: sprintf("%02d%02d%02d", [
                    controller.selectedDate.year,
                    controller.selectedDate.month,
                    controller.selectedDate.day
                  ]),
                  apprTot: num.parse(_amountTextController.value.text),
                  type: "R",
                  status: "U",
                  // image: controller.imageList.length == 0
                  //     ? null
                  //     : base64Encode(controller.imageList[0]),
                  account: account,
                  image: controller.getEncodedImage(),
                  comment: _commentTextController.value.text,
                );

                if (update) {
                  int index = Get.find<ReceiptListController>()
                      .findIndexById(data.receiptId);
                  Get.find<ReceiptListController>()
                      .receipt_list
                      .removeAt(index);
                  Get.find<ReceiptListController>()
                      .receipt_list
                      .insert(index, data);
                } else {
                  Get.find<ReceiptListController>()
                      .receipt_list
                      .insert(0, data);
                }
                Get.find<ReceiptListController>().update();
                Get.find<MainController>().selectedIndex = 2;
                Get.find<MainController>().update();
                controller.update();
                Get.back();
              },
              // child: Text(
              //   '등록',
              //   style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
              // ),
              child: Icon(Icons.add_box, color: Colors.white.withOpacity(0.9)),
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
          child: SingleChildScrollView(
              child: GetBuilder<ReceiptWriteController>(
            builder: (_) => Column(
              children: [
                eContainer(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getTitle('사용일자'),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () => _selectDate(context),
                                child: getValue(
                                    controller.getStringSelectedDate())),
                            // TextButton(
                            //     onPressed: () => _selectDate(context),
                            //     child: Text(
                            //       '변경',
                            //       style: TextStyle(
                            //         fontSize: 13,
                            //       ),
                            //     )),
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
                      getTitle('증빙계정'),
                      Text('${account}'),
                    ],
                  ),
                ),
                eContainer(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getTitle('사용금액'),
                      Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          // key: _amountFormKey,
                          controller: _amountTextController,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          maxLength: 10,
                          maxLines: 1,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ], //
                        ),
                      )
                    ],
                  ),
                ),
                oContainer(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getTitle('적요'),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ))),
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          key: _commentFormKey,
                          controller: _commentTextController,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          maxLength: 100,
                          maxLines: 6,
                        ),
                      )
                    ],
                  ),
                ),
                eContainer(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getTitle('증빙파일'),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                this.getImage(ImageSource.camera);
                              },
                              // child: Icon(Icons.attach_file),
                              child: Icon(Icons.add_a_photo)),
                          Text('/'),
                          TextButton(
                            onPressed: () {
                              this.getImage(ImageSource.gallery);
                            },
                            // child: Icon(Icons.attach_file),
                            child: Icon(Icons.add_photo_alternate),
                          ),
                        ],
                      ),
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
                              crossAxisCount: 2),
                      itemCount: controller.imageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Stack(children: [
                            InkWell(
                              onTap: () {
                                // Get.
                              },
                              child: Container(
                                alignment: Alignment.center,
                                // margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(15)),
                                child:
                                    Image.memory(controller.imageList[index]),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.imageList.removeAt(index);
                                controller.update();
                              },
                              child: Container(
                                  color: Colors.white.withOpacity(0.5),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  )),
                            ),
                          ]),
                        );
                      }),
                ),
              ],
            ),
          )),
        ));
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
      padding: EdgeInsets.all(0),
      // decoration: BoxDecoration(
      //   border: Border.all(width: 0.0),
      // ),
      child: Text(
        str,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dotted),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            )),
            child: child!,
          );
        });

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
