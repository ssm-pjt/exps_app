import 'package:exps_app/notice/model/notice_repository.dart';
import 'package:get/get.dart';

import '../model/notice_data.dart';

class NoticeController extends GetxController {
  NoticeRepository noticeRepository = NoticeRepository();

  List<NoticeData> list = <NoticeData>[].obs;

  void getList() {
    list = noticeRepository.getList();
  }
}
