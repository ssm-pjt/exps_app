import 'package:flutter/material.dart';
import 'package:exps_app/etc/controller/card_info_controller.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class CardInfoView extends GetView<CardInfoController> {
  @override
  Widget build(BuildContext context) {
    CardInfoController controller = Get.put(CardInfoController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '카드정보',
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
      body: GetBuilder<CardInfoController>(
        builder: (_) => Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(

              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  Container(
                    child: GestureDetector(
                        onTap: () {
                          controller.pageController.previousPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                        },
                        child: controller.viewPageIndex == 0
                            ? Container()
                            : Icon(Icons.arrow_left)),
                  ),
                  Expanded(
                      // width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height * 0.4,
                      // margin: EdgeInsets.symmetric(horizontal: 4.0),
                      // padding: EdgeInsets.all(20),
                      // color: Colors.grey.shade300,
                      child: PageView.builder(
                          controller: controller.pageController,
                          physics: BouncingScrollPhysics(),
                          onPageChanged: (index) {
                            controller.viewPageIndex = index;
                            controller.update();
                          },
                          clipBehavior: Clip.antiAlias,
                          allowImplicitScrolling: true,
                          pageSnapping: true,
                          itemCount: controller.cardList.length,
                          itemBuilder: (context, index) {
                            return Container(
                                decoration: BoxDecoration(
                                  color: controller.cardList[index].color,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
                                // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                padding: EdgeInsets.zero,
                                // color: controller.cardList[index].color,
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Transform.scale(
                                        scale: 0.8,
                                        child: RotatedBox(
                                          quarterTurns: 1,
                                          child: controller.cardList[index].image,
                                        ),
                                      ),
                                    ),
                                    // Positioned(
                                    //   left: 20,
                                    //   top: 20,
                                    //   child: Text(
                                    //       controller
                                    //           .cardList[index].cardCompanyName,
                                    //       style:
                                    //           TextStyle(color: Colors.black)),
                                    // ),
                                    // Positioned(
                                    //   left: 20,
                                    //   bottom: 20,
                                    //   child: Text(
                                    //       controller.cardList[index].cardNo,
                                    //       style:
                                    //           TextStyle(color: Colors.black)),
                                    // ),
                                  ],
                                ));
                          })
                      // child: PageView(
                      //   controller: controller.pageController,
                      //   physics: BouncingScrollPhysics(),
                      //   onPageChanged: (index) {

                      //   },
                      //   children: [
                      //     Container(
                      //       margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
                      //       padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      //       color: Colors.green,
                      //       child: Stack(
                      //         children: [
                      //           Positioned(
                      //             left: 10,
                      //             top: 10,
                      //             child: Text('하나카드', style: TextStyle(color: Colors.white)),
                      //           ),
                      //           Positioned(
                      //             left: 10,
                      //             bottom: 10,
                      //             child: Text('1234-1234-1234-1234', style: TextStyle(color: Colors.white)),
                      //           ),
                      //         ],
                      //       )
                      //       ),

                      //     Container(
                      //       margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
                      //       padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      //       color: Colors.blue,
                      //       child: Stack(
                      //         children: [
                      //            Positioned(
                      //             left: 10,
                      //             top: 10,
                      //             child: Text('신한카드', style: TextStyle(color: Colors.white)),
                      //           ),
                      //           Positioned(
                      //             left: 10,
                      //             bottom: 10,
                      //             child: Text('1234-1234-1234-1234', style: TextStyle(color: Colors.white)),
                      //           ),

                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                      ),
                  Container(
                    child: GestureDetector(
                        onTap: () {
                          controller.pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                        },
                        child: controller.viewPageIndex ==
                                controller.cardList.length - 1
                            ? Container()
                            : Icon(Icons.arrow_right)),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < controller.cardList.length; i++)
                  _indecator(context, i),
              ],
            ),
            SizedBox(height: 30,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,  
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${controller.cardList[_.viewPageIndex].cardCompanyName}'),
                SizedBox(height: 10,),
                Text('${controller.cardList[_.viewPageIndex].cardNo}'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _indecator(context, int i) {
    bool isActive = i == controller.viewPageIndex;

    return Container(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: 10,
        width: 12,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
              ? BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.72),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                  offset: Offset(
                    0.0,
                    0.0,
                  ),
                )
              : BoxShadow(
                  color: Colors.transparent,
                )
          ],
          shape: BoxShape.circle,
          color: isActive ? Theme.of(context).primaryColor : Color(0XFFEAEAEA),
        ),
      ),
    );
  }
}
