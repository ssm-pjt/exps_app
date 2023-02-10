import 'package:exps_app/card/controller/card_list_controller.dart';
import 'package:exps_app/home/controller/home_controller.dart';
import 'package:exps_app/login/controller/login_controller.dart';
import 'package:exps_app/receipt/controller/receipt_list_controller.dart';
import 'package:get/get.dart';

import 'approval/controller/approval_list_controller.dart';
import 'etc/controller/etc_list_controller.dart';
import 'main/controller/main_controller.dart';

class GetBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(() => CardListController(), permanent: true,);
    Get.put(() => ReceiptListController(), permanent: true);
    Get.put(() => ApprovalListController(), permanent: true);
    Get.put(() => HomeController(), permanent: true);
    Get.lazyPut(() => EtcListController(), );

    Get.put(() => MainController(), permanent: true);
  }

}
