import 'package:exps_app/approval/model/account.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ApprovalWriteController extends GetxController {
  var approvalNo = '';

  // final accountList = [
  //   '교통비',
  //   '대외활동비',
  //   '식비',
  //   '교육비',
  //   '소모품비'
  // ];

  final List<Account> accountList = [];

  @override
  void onInit() {
    accountList.add(Account(accountName: "교통비", selected: false));
    accountList.add(Account(accountName: "대외활동비", selected: false));
    accountList.add(Account(accountName: "식비", selected: false));
    accountList.add(Account(accountName: "교육비", selected: false));
    accountList.add(Account(accountName: "소모품비", selected: false));
    super.onInit();
  }

  selectAccount(index) {
    accountList[index].selected = !accountList[index].selected;

    for (int i = 0; i < accountList.length; i++) {
      if (i == index) {
        continue;
      }
      accountList[i].selected = false;
    }

    update();
  }

  getSelectedValue() {
    for (int i = 0; i < accountList.length; i++) {
      if (accountList[i].selected) {
        return accountList[i].accountName;
      }
    }

    return '';
  }

  getApprovalNo() {
    approvalNo = Uuid().v4().substring(0, 18);
    return approvalNo;
  }
}
