import 'package:flutter/material.dart';
import 'package:exps_app/approval/controller/approval_list_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'approval_detail_view.dart';

class ApprovalListView extends GetView<ApprovalListController> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        //
      },
      child: Scaffold(
          body: Scrollbar(
        child: GetBuilder<ApprovalListController>(
            builder: (_) => ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.approvalList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      startActionPane: ActionPane(
                        extentRatio: 0.3,
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        dragDismissible: false,
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              controller.cancel(index);
                            },
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.cancel,
                            label: '결재취소',
                          ),
                        ],
                      ),
                      child: Card(
                        borderOnForeground: true,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        elevation: 3,
                        shadowColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.0,
                            )),
                        child: ListTile(
                          onTap: () {
                            Get.to(() => ApprovalDetailView(),
                                transition: Transition.rightToLeftWithFade,
                                arguments: {
                                  'data': _.approvalList[index].getApprovalData(),
                                });
                          },
                          // leading: Container(
                          //   width: 75,
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 8,
                          //     vertical: 4,
                          //   ),
                          //   decoration: BoxDecoration(
                          //     // color: Color(0xff2B3044),
                          //     color: Color(0xff9a9a9a),
                          //     borderRadius: BorderRadius.circular(20),
                          //   ),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Flexible(
                          //         child: Text(
                          //           _.approvalList[index].account,
                          //           softWrap: false,
                          //           maxLines: 1,
                          //           overflow: TextOverflow.clip,
                          //           style: TextStyle(
                          //             fontSize: 11,
                          //             color: Colors.white,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          trailing: Container(
                            // alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Icon(Icons.arrow_forward_ios, size: 18.0,)),
                          title: Container(
                            padding: EdgeInsets.only(
                              left: 5.0,
                              top: 10.0,
                              right: 0.0,
                              bottom: 5.0
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${_.approvalList[index].account}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[900])
                                            ),
                                            SizedBox(height: 4,),
                                            Text(
                                            "${_.approvalList[index].purpose}",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.grey[600])
                                            ),
                                        ],
                                      )
                                      ),
                                    Container(
                                        alignment: Alignment.bottomRight,
                                        child: FittedBox(
                                            alignment: Alignment.centerRight,
                                            child: Text('${_.sum(index)} 원',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black)))),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _.getDocumentDate(index),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600]),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      controller.statusContainer(index),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
      )),
    );
  }
}
