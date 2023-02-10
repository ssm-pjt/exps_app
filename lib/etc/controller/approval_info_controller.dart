import 'package:exps_app/etc/model/approval_info.dart';
import 'package:exps_app/etc/model/approval_info_repository.dart';
import 'package:get/get.dart';

class ApprovalInfoController extends GetxController {
  ApprovalInfoRepository repository = ApprovalInfoRepository();
  List<ApprovalInfo> approvalList = [];
  List<ApprovalInfo> accountApprovalList = [];
  String defaultMaster = '00002';
  String defaultMaster2 = 'A0002';

  void getApprovalList() {
    this.approvalList = repository.getApprovalList();
  }

  void getAccountApprovalList() {
    this.accountApprovalList = repository.getAccountApprovalList();
  }
}
