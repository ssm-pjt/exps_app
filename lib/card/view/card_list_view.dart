import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exps_app/approval/view/approval_write_view.dart';
import 'package:exps_app/card/controller/card_list_controller.dart';
import 'package:exps_app/card/view/card_detail_view.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';


class CardListView extends GetView<CardListController> {
  Future<void> _loadData() async {
    controller.listUpdate();
  }

  @override
  Widget build(BuildContext context) {
    CardListController controller = Get.put(CardListController());

    return GetBuilder<CardListController>(
      builder: (_) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(
            bottom: 50.0,
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
              if (Get.put(CardListController()).selectedCard().length == 0) {
                Get.snackbar("알림", "사용 건을 하나 이상 선택하세요");
                return;
              }
              HapticFeedback.lightImpact();

              Get.to(() => ApprovalWriteView(),
                  transition: Transition.downToUp,
                  arguments: {
                    'data': Get.find<CardListController>().selectedCard(),
                  });
            },
          ),
        ),
        body: Scrollbar(
            child: RefreshIndicator(
              onRefresh: _loadData,
              child: ListView.builder(
                // controller: _.scrollController,
                physics: BouncingScrollPhysics(),
                // padding: EdgeInsets.zero,
                padding: EdgeInsets.only(
                  bottom: 100,
                ),
                shrinkWrap: true,
                primary: true,
                itemCount: controller.card_list.length,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  return Card(
                    borderOnForeground: true,
                    color: controller.isSelected(index)
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
                          Get.to(() => CardDetail(),
                              transition: Transition.rightToLeftWithFade,
                              arguments: {
                                "data": _.card_list[index].getCardData(),
                              });
                        },
                        selected: _.card_list[index].select,
                        leading: Container(
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                          width: 20,
                          child: _.checkbox(index),
                        ),
                        title: Container(
                          margin: EdgeInsets.only(top: 3.0, bottom: 3.0),
                          padding: EdgeInsets.all(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                          _.card_list[index].merchant ?? '',
                                          style: TextStyle(
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[900])),
                                    )),
                                    Container(
                                        alignment: Alignment.bottomRight,
                                        child: FittedBox(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                                _.card_list[index]
                                                        .getStringApprTot() +
                                                    ' 원',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    overflow: TextOverflow.ellipsis,
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
                                      _.card_list[index].getApprDateTime(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700]),
                                    ),
                                    _.getStatusContainer(index),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: Container(
                          width: 15.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => CardDetail(),
                                    transition: Transition.rightToLeftWithFade,
                                    arguments: {
                                      "data": _.card_list[index].getCardData(),
                                    });
                                },
                                child: Icon(Icons.arrow_forward_ios, size: 18.0), ),
                            ],
                          ),
                        )),
                  );
                },
              ),
            )),
      ),
    );
  }
}
