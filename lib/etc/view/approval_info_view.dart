import 'package:flutter/material.dart';
import 'package:exps_app/etc/controller/approval_info_controller.dart';
import 'package:get/get.dart';

class ApprovalInfoView extends GetView<ApprovalInfoController> {
  @override
  Widget build(BuildContext context) {
    controller.getApprovalList();
    controller.getAccountApprovalList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '결재선지정',
        ),
        actions: [
          // TextButton(
          //   child: Icon(Icons.edit, color: Colors.white.withOpacity(0.9)),
          //   onPressed: () {
          //     //개인정보는 서버에
          //   },
          //   // style: TextButton.styleFrom(
          //   //   textStyle: const TextStyle(fontSize: 12),
          //   // ),
          // )
        ],
      ),
      body: GetBuilder<ApprovalInfoController>(
          builder: (_) => SingleChildScrollView(
            child: Container(
              child: GestureDetector(
              onHorizontalDragUpdate: (details){
              if (details.primaryDelta! > 0) {
              Get.back();
              }
              },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      child: Text("부서", style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    ListView(
                      primary: true,
                      shrinkWrap: true,
                      children: [
                        for (int index = 0; index < controller.approvalList.length; index++)
                          RadioListTile(
                            // activeColor: Theme.of(context).primaryColor,
                            selected: controller.accountApprovalList[index].id == _.defaultMaster2 ? true : false,
                            activeColor: Colors.grey,
                            selectedTileColor: Colors.grey.shade100,
                            tileColor: Colors.white,
                            title: Text(
                              '${controller.approvalList[index].name} ${controller.approvalList[index].level}',
                               style: TextStyle(
                                   color: Colors.black
                              ),),
                                groupValue: _.defaultMaster,
                                onChanged: (value) {
                                  // _.defaultMaster = value.toString();
                                  // _.update();
                              },
                              value: _.approvalList[index].id,
                            )
                      ],
                    ),
                    // Container(
                    //   height: 200,
                    //   child: ListView.builder(
                    //       itemCount: controller.approvalList.length,
                    //       itemBuilder: (context, index) {
                    //         return RadioListTile(
                    //           activeColor: Theme.of(context).primaryColor,
                    //           title: Text(
                    //               '${controller.approvalList[index].name}'),
                    //               groupValue: _.defaultMaster,
                    //               onChanged: (value) {
                    //                 _.defaultMaster = value.toString();
                    //                 _.update();
                    //             },
                    //             value: _.approvalList[index].id,
                    //           );
                    //       }),
                    // ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      child: Text("회계팀", style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    ListView(
                      primary: true,
                      shrinkWrap: true,
                      children: [
                        for (int index = 0; index < controller.accountApprovalList.length; index++)
                          RadioListTile(
                            selected: controller.accountApprovalList[index].id == _.defaultMaster2 ? true : false,
                            activeColor: Colors.grey,
                            selectedTileColor: Colors.grey.shade100,
                            tileColor: Colors.white,
                            title: Text(
                                '${controller.accountApprovalList[index].name}  ${controller.accountApprovalList[index].level}',
                                style: TextStyle(
                                  color: Colors.black )
                            ),
                            groupValue: _.defaultMaster2,
                            onChanged: (value) {
                              // _.defaultMaster2 = value.toString();
                              _.update();
                            },
                            value: _.accountApprovalList[index].id,
                          )
                      ],
                    )
                    // Expanded(
                    //   child: ListView.builder(
                    //       itemCount: controller.accountApprovalList.length,
                    //       itemBuilder: (context, index) {
                    //         return RadioListTile(
                    //           selected: false,
                    //           activeColor: Colors.black26,
                    //           selectedTileColor: Colors.grey.shade100,
                    //           title: Text(
                    //               '${controller.accountApprovalList[index].name}'),
                    //           groupValue: _.defaultMaster2,
                    //           onChanged: (value) {
                    //             // _.defaultMaster2 = value.toString();
                    //             _.update();
                    //           },
                    //           value: _.accountApprovalList[index].id,
                    //         );
                    //       }),
                    // ),
                  ],
                )),
            )
          )),
    );
  }
}
