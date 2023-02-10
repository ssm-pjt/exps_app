import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exps_app/approval/view/approval_write_view.dart';
import 'package:exps_app/receipt/controller/receipt_list_controller.dart';
import 'package:exps_app/receipt/view/receipt_detail_view.dart';
import 'package:exps_app/receipt/view/receipt_write_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class ReceiptListView extends GetView<ReceiptListController> {
  Future<void> _loadData() async {
    controller.listUpdate();
  }

  @override
  Widget build(BuildContext context) {
    ReceiptListController controller = Get.put(ReceiptListController());

    return GetBuilder<ReceiptListController>(
      builder: (_) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: _.fabIsVisible.isTrue ? 1.0 : 0.0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: _.isSelectList() ? writeApproval(context) : writeReceipt(context) ,
          ),
        ),
        body: Scrollbar(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _loadData,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        bottom: 100,
                      ),
                      shrinkWrap: true,
                      primary: true,
                      itemCount: controller.receipt_list.length,
                      itemBuilder: (
                          BuildContext context,
                          int index,
                          ) {
                        return Slidable(
                          key: const ValueKey(0),
                          //직접 등록한 영수증건(R)만 수정/삭제가 가능
                          enabled: (_).edit(index),
                          startActionPane: ActionPane(
                            extentRatio: 0.3,
                            motion: const ScrollMotion(),
                            dismissible: DismissiblePane(onDismissed: () {}),
                            dragDismissible: false,
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  Get.to(() => ReceiptWrite(),
                                      arguments: {"index": index});
                                },
                                backgroundColor: Color(0xFF7BC043),
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: '수정',
                              ),
                            ],
                          ),

                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            extentRatio: 0.3,
                            dragDismissible: false,
                            children: [
                              SlidableAction(
                                // An action can be bigger than the others.
                                onPressed: (context) {
                                  _.delete(index);
                                },
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: '삭제',
                                autoClose: true,
                              ),
                            ],
                          ),
                          child: Card(
                            borderOnForeground: true,
                            color: controller.receipt_list[index].select
                                ? Colors.deepOrange.shade300
                                : Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            elevation: 3,
                            shadowColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0,
                                )
                            ),
                            child: ListTile(
                              minLeadingWidth : 10,
                              onLongPress: () {
                                _.setSelect(index);
                                HapticFeedback.selectionClick();
                              },
                              onTap: () {
                                // _.setUnSelect(index);
                                HapticFeedback.lightImpact();

                                Get.to(() => ReceiptDetail(),
                                    transition: Transition.rightToLeftWithFade,
                                    arguments: {
                                      "data": _.receipt_list[index].getReceptData(),
                                    });
                              },
                              selected: _.receipt_list[index].select,
                              leading: Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(0),
                                  width: 20,
                                  child: _.checkbox(index)),
                              title: Container(
                                margin: EdgeInsets.only(top: 3.0, bottom: 3.0),
                                padding: EdgeInsets.all(0),
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 0.0,
                                                  top: 12.0,
                                                  right: 6.0,
                                                  bottom: 12.0,
                                                ),
                                                child: Text(
                                                    _.receipt_list[index].account,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.grey[900])),
                                              )),
                                          Container(
                                              alignment: Alignment.bottomRight,
                                              child: FittedBox(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      _.receipt_list[index]
                                                          .getStringApprTot() +
                                                          ' 원',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black)))),
                                        ]),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 5.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _.receipt_list[index].getApprDt(),
                                            style: TextStyle(
                                                fontSize: 13, color: Colors.grey[700]),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          _.getStatusContainer(index),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Container(
                                alignment: Alignment.center,
                                width: 15.0,
                                child: GestureDetector(
                                  onTapDown: (details) {
                                    _.setSelect(index);
                                  },
                                  onTapUp: (details) {
                                    _.setUnSelect(index);
                                  },
                                  onTap: () {
                                    // String id = _.receipt_list[index].id;
                                    Get.to(() => ReceiptDetail(),
                                        transition: Transition.rightToLeftWithFade,
                                        arguments: {
                                          "data": _.receipt_list[index].getReceptData(),
                                        });
                                  },
                                  child: Icon(Icons.arrow_forward_ios, size: 18.0), ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )),
      ),
    );


  }

  Widget writeReceipt(context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            isDismissible: true,
            enableDrag: true,
            // clipBehavior: Clip.antiAlias,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                // height: MediaQuery.of(context).size.height * 0.3,
                  height: 155,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Center(
                                  child: Container(
                                    width: 40,
                                    height: 5,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                  ))),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   padding: EdgeInsets.only(
                      //     left: 20.0,
                      //     top: 10.0,
                      //   ),
                      //   child: Text('등록', style: TextStyle(color: Colors.black54),)),
                      Container(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                Get.back();
                                Get.toNamed("/receipt/write", arguments: {"account": "교통비"});
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(Icons.drive_eta, size: 30.0, color: Colors.white,)),
                                  SizedBox(height: 7,),
                                  Text('교통비',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                    ),),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                Get.back();
                                Get.toNamed("/receipt/write", arguments: {"account": "대외활동비"});
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.connect_without_contact, size: 30.0, color: Colors.white,)),
                                  SizedBox(height: 7,),
                                  Text('대외활동비',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                    ),),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                Get.back();
                                Get.toNamed("/receipt/write", arguments: {"account": "식비"});
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(Icons.fastfood, size: 30.0, color: Colors.white,)),
                                  SizedBox(height: 7,),
                                  Text('식비',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                    ),),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                Get.back();
                                Get.toNamed("/receipt/write", arguments: {"account": "교육비"});
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(Icons.cast_for_education, size: 30.0, color: Colors.white,)),
                                  SizedBox(height: 7,),
                                  Text('교육비',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                    ),),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                Get.back();
                                Get.toNamed("/receipt/write", arguments: {"account": "소모품비"});
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(Icons.corporate_fare, size: 30.0, color: Colors.white,)),
                                  SizedBox(height: 7,),
                                  Text('소모품비',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                  ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ));
            });
      },
    );
  }

  Widget writeApproval(context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 0.0,
      ),
      child: SpeedDial(
        icon: Icons.edit,

        buttonSize: Size(50, 50),
        label: Text(
          '결의서작성',
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        onPress: () {
          if (!Get.put(ReceiptListController()).isSelectList()) {
            Get.snackbar("알림", "사용 건을 하나 이상 선택하세요");
            return;
          }
          HapticFeedback.lightImpact();

          Get.to(() => ApprovalWriteView(),
              transition: Transition.downToUp,
              arguments: {
                'data': Get.find<ReceiptListController>().selectedReceipt(),
              });
        },
      ),
    );
  }
}