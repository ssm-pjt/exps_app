import 'package:flutter/material.dart';
import 'package:exps_app/main/controller/main_controller.dart';
import 'package:exps_app/notice/controller/notice_controller.dart';
import 'package:get/get.dart';

class NoticeView extends GetView<NoticeController> {
  @override
  Widget build(BuildContext context) {
    NoticeController controller = NoticeController();
    controller.getList();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '알림',
          ),
        ),
        body: Container(
            child: ListView.builder(
                // separatorBuilder: (context, index) => Divider(),
                itemCount: controller.list.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    collapsedTextColor: Colors.black,
                    textColor: Theme.of(context).primaryColor,
                    initiallyExpanded: false,
                    onExpansionChanged: (bool) {

                      if (bool) {
                        MainController mcontroller = Get.put(MainController());

                        if (controller.list[index].unread) {
                          mcontroller.noticeCnt -= 1;
                          mcontroller.update();
                          controller.list[index].unread = false;
                        }

                      }
                    },

                    controlAffinity: ListTileControlAffinity.leading,
                    trailing: controller.list[index].unread == true
                        ? Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).primaryColor.withOpacity(0.5),
                                  ]),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text("N E W",
                                style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          )
                        : null,
                    title: Text(controller.list[index].title, overflow: TextOverflow.ellipsis,),
                    subtitle: Text((controller.list[index].date)),
                    expandedAlignment: Alignment.topCenter,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                            bottom: 10,
                          ),
                          color: Colors.grey.shade200,
                          child: Text(
                            controller.list[index].content,
                            style: TextStyle(fontSize: 14),
                          )),
                    ],
                  );
                }),
          ),
        );
  }
}
