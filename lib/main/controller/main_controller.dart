import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exps_app/approval/view/approval_list_view.dart';
import 'package:exps_app/card/view/card_list_view.dart';
import 'package:exps_app/etc/view/etc_list_view.dart';
import 'package:exps_app/home/controller/home_controller.dart';
import 'package:exps_app/home/view/home_view.dart';
import 'package:exps_app/receipt/view/receipt_list_view.dart';
import 'package:get/get.dart';
import 'package:local_assets_server/local_assets_server.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:webview_flutter/webview_flutter.dart';

// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';

// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

enum Page { Home, Card, Receipt, Approval, Setting }

class MainController extends GetxController {
  static bool isListening = false;
  String? address;
  int? port;

  int noticeCnt = 1;
  int selectedIndex = 0;
  bool showSearch = false;

  List<Search> searchList = [];
  List<int> history = [0];

  var children = [
    HomeView(),
    CardListView(),
    ReceiptListView(),
    ApprovalListView(),
    EtcListView(),
  ];

  late ScrollController scrollController;

  @override
  void onInit() {
    //local webserver
    if (!isListening) {
      initServer();
    }

    //
    netCheck();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    scrollController = ScrollController();
    super.onInit();
  }

  initServer() async {
    // var mcontroller = Get.put(MainController());

    final server = new LocalAssetsServer(
        address: InternetAddress.loopbackIPv4,
        assetsBasePath: 'web',
        logger: DebugLogger(),
        port: 9000);

    final address = await server.serve();

    // setState(() {
    this.address = address.address;
    this.port = server.boundPort!;
    isListening = true;

    // });

    searchList.add(Search(condition: '3개월', selected: false));
    searchList.add(Search(condition: '6개월', selected: true));
    searchList.add(Search(condition: '9개월', selected: false));
    searchList.add(Search(condition: '12개월', selected: false));
  }

  void netCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      Get.snackbar('알림', '인터넷에 연결되어야 정상적인 서비스를 이용하실 수 있습니다',
          snackPosition: SnackPosition.TOP);
    }
  }

  void onItemTapped(int index) {
    var page = Page.values[index];

    //페이지에 따라 검색버튼 노출
    switch (page) {
      case Page.Card:
      case Page.Receipt:
      case Page.Approval:
        showSearch = true;
        break;
      default:
        {
          showSearch = false;
        }
    }

    if (page == Page.Home) {
      Get.find<HomeController>().loadData();
    }

    scrollController.jumpTo(0);
    selectedIndex = index;

    //안드로이드 백버튼 히스토리 기록
    if (history.last != index) {
      history.add(index);
    }

    update();
  }

  //안드로이드 백버튼 실행시
  Future<bool> willPop() async {
    if (history.length == 1) {
      Get.defaultDialog(
        title: '',
        content: Text(tr('btn.endTitle')),
        cancel: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(tr('btn.cancle')),
        ),
        confirm: TextButton(
          onPressed: () {
            // exit(0);
            SystemNavigator.pop();
          },
          child: Text(tr('btn.end')),
        ),
      );

      return true;
    } else {
      history.removeLast();
      selectedIndex = history.last;

      update();
      return false;
    }
  }

  void selectSearch(index) {
    searchList[index].selected = !searchList[index].selected;

    for (int i = 0; i < searchList.length; i++) {
      if (i == index) continue;

      searchList[i].selected = false;
    }
  }
}

class Search {
  Search({
    required this.condition,
    required this.selected,
  });

  String condition;
  bool selected;
}
