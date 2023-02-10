import 'approval_info.dart';

class ApprovalInfoRepository {
  List<ApprovalInfo> getApprovalList() {
    List<ApprovalInfo> approvalList = [];

    approvalList.add(ApprovalInfo(id: "00001", name: '이지은', dept: '운영팀', level: '과장'));
    approvalList.add(ApprovalInfo(id: "00002", name: '박은빈', dept: '운영팀', level: '차장'));
    approvalList.add(ApprovalInfo(id: "00003", name: '김팀장', dept: '운영팀', level: '부장'));

    return approvalList;
  }


  List<ApprovalInfo> getAccountApprovalList() {
    List<ApprovalInfo> approvalList = [];

    approvalList.add(ApprovalInfo(id: "A0001", name: '김철수', dept: '회계팀', level: '과장'));
    approvalList.add(ApprovalInfo(id: "A0002", name: '김영희', dept: '회계팀', level: '과장'));
    approvalList.add(ApprovalInfo(id: "A0003", name: '이순신', dept: '회계팀', level: '차장'));
    approvalList.add(ApprovalInfo(id: "A0004", name: '김팀장', dept: '회계팀', level: '부장'));
    approvalList.add(ApprovalInfo(id: "A0005", name: '이팀장', dept: '회계팀', level: '부장'));

    return approvalList;
  }


}
