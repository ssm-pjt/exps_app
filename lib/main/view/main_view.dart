import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:exps_app/main/controller/main_controller.dart';

class MainView extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    MainController controller = Get.put(MainController());
    return WillPopScope(
      onWillPop: controller.willPop,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: NestedScrollView(
            controller: controller.scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  floating: false,
                  pinned: true,
                  snap: false,
                  shadowColor: Colors.grey[400],
                  automaticallyImplyLeading: false,
                  // bottom: TabBarView(
                  //
                  // children: [
                  //   Tab(height: 10,),
                  // ],
                  // ),

                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // easy_localization 로 title 에 맞는 문자열로 변환
                        Text(tr('title')),
                      ]),
                  actions: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      GetBuilder<MainController>(
                        builder: (_) => Visibility(
                          visible: _.showSearch,
                          child: InkWell(
                            child: Icon(
                              Icons.filter_list,
                              color: Colors.white70,
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
                                        title: Text(tr('btn.search')),
                                        content: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '기간설정',
                                                  style:
                                                      TextStyle(fontSize: 13.0),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            controller
                                                                .searchList
                                                                .length;
                                                        i++)
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            controller
                                                                .selectSearch(
                                                                    i);
                                                          });
                                                        },
                                                        child: Card(
                                                          elevation: 2,
                                                          margin:
                                                              EdgeInsets.zero,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.zero,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              vertical: 2.0,
                                                              horizontal: 10.0,
                                                            ),
                                                            color: controller
                                                                    .searchList[
                                                                        i]
                                                                    .selected
                                                                ? Colors
                                                                    .redAccent
                                                                : Colors.white,
                                                            child: Text(
                                                                '${controller.searchList[i].condition}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      11.0,
                                                                  color: controller
                                                                          .searchList[
                                                                              i]
                                                                          .selected
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                )),
                                                          ),
                                                        ),
                                                      )
                                                  ],
                                                )
                                              ]),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              clipBehavior: Clip.none,
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                minimumSize: Size(30, 30),
                                                primary: Colors.redAccent,
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text(tr('btn.cancle'),
                                                  style: TextStyle(
                                                    fontSize: 9.0,
                                                  ))),
                                          ElevatedButton(
                                            clipBehavior: Clip.none,
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              minimumSize: Size(30, 30),
                                              primary: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(tr('btn.confirm'),
                                                style: TextStyle(
                                                  fontSize: 9.0,
                                                )),
                                          )
                                        ],
                                      );
                                    });
                                  });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed("/notice");
                        },
                        child: GetBuilder<MainController>(
                          builder: (_) => Container(
                            margin: const EdgeInsets.only(
                              right: 10.0,
                            ),
                            alignment: Alignment.centerRight,
                            width: 23,
                            child: badges.Badge(
                              badgeContent: Text('${controller.noticeCnt}',
                                  style: TextStyle(color: Colors.white)),
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              showBadge: _.noticeCnt > 0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ])
                  ],
                ),
              ];
            },
            body: GetBuilder<MainController>(
                builder: (_) => IndexedStack(
                    index: _.selectedIndex, children: _.children))),
        bottomNavigationBar: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: Opacity(
              opacity: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.black12, width: 1)),
                ),
                child: GetBuilder<MainController>(
                  builder: (_) => BottomNavigationBar(
                    elevation: 0,
                    iconSize: 20,
                    selectedFontSize: 12,
                    unselectedFontSize: 12,
                    enableFeedback: true,
                    currentIndex: _.selectedIndex,
                    // selectedItemColor: Colors.grey[900],
                    selectedItemColor: Theme.of(context).primaryColor,
                    unselectedItemColor: Colors.grey[600],
                    showUnselectedLabels: true,
                    onTap: _.onItemTapped,
                    selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.normal),
                    type: BottomNavigationBarType.fixed,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        tooltip: '홈',
                        activeIcon: Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Icon(Icons.home),
                        ),
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Icon(Icons.home_outlined),
                        ),
                        label: '홈',
                      ),
                      BottomNavigationBarItem(
                        tooltip: '법인카드',
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Icon(Icons.credit_card_outlined),
                        ),
                        activeIcon: Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Icon(Icons.credit_card),
                        ),
                        label: '법인카드',
                      ),
                      BottomNavigationBarItem(
                        tooltip: '영수증',
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Icon(Icons.receipt_long_outlined),
                        ),
                        activeIcon: Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Icon(Icons.receipt_long),
                        ),
                        label: '영수증',
                      ),
                      BottomNavigationBarItem(
                        tooltip: '결재상태',
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Icon(Icons.approval_outlined),
                        ),
                        activeIcon: Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Icon(Icons.approval),
                        ),
                        label: '결재상태',
                      ),
                      BottomNavigationBarItem(
                        tooltip: '설정',
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Icon(Icons.settings_outlined),
                        ),
                        activeIcon: Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Icon(Icons.settings),
                        ),
                        label: '설정',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
