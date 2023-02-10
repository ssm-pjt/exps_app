import 'package:flutter/material.dart';
import 'package:exps_app/etc/controller/priority_info_controller.dart';
import 'package:get/get.dart';

class PriorityInfoView extends GetView<PriorityInfoController> {
  PriorityInfoController controller = Get.put(PriorityInfoController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '우선순위',
          ),
          actions: [
          ],
        ),
        body: ReorderableListView.builder(
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                key: UniqueKey(),
                // color: Colors.white,
            child: GestureDetector(
            onHorizontalDragUpdate: (details){
            if (details.primaryDelta! > 0) {
            Get.back();
            }
            },
                child: ListTile(
                  title: Text('${controller.list[index]}'),
                  trailing: Icon(Icons.drag_handle),
                ))
            );
          },
          itemCount: controller.list.length,
          onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final String item = controller.list.removeAt(oldIndex);
            controller.list.insert(newIndex, item);
          },
        ));
  }
}
