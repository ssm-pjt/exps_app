import 'package:flutter/material.dart';
import 'package:exps_app/home/controller/home_controller.dart';
import 'package:exps_app/main/controller/main_controller.dart';
import 'package:exps_app/util/string_util.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeView extends GetView<HomeController> {
  static const String remain = '잔여';
  static const String proceed = '진행';
  static const String complete = '완료';

  Duration pageDuration = Duration(milliseconds: 1000);

  _loadData() async {
    Get.put(HomeController()).loadData();
  }

  @override
  Widget build(BuildContext context) {
    // HomeController controller = Get.put(HomeController());
    controller.loadData();

    //다른 페이지 이동후 다시 돌아오면 첫번째 페이지가 보이는 현상 해결
    Future<void>.delayed(
      Duration(milliseconds: 1),
      () {
        controller.pageController.jumpToPage(controller.pageIndex);
        
      },
    );

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _loadData(),
        child: SingleChildScrollView(
          child: GetBuilder<HomeController>(
            builder: (_) => Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.83 - 50,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                        pageSnapping: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        controller: _.pageController,
                        onPageChanged: (index) {
                          controller.tabController.animateTo(index,
                              duration: pageDuration,
                              curve: Curves.fastLinearToSlowEaseIn);
                          controller.pageIndex = index;
                        },
                        children: [
                          //법인카드
                          cardPage(context, _),
                          //영수증
                          receiptPage(context, _),
                        ]),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 3),
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TabBar(
                      controller: controller.tabController,
                      onTap: (index) {
                        controller.pageController.animateToPage(index,
                            duration: pageDuration,
                            curve: Curves.fastLinearToSlowEaseIn);
                        _.pageIndex = index;
                      },
                      // unselectedLabelColor: Colors.green,
                      labelColor: Colors.black,
                      indicatorColor: Theme.of(context).primaryColor,
                      unselectedLabelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      // indicator: BoxDecoration(
                      //   color: Colors.black,
                      // ),
                      tabs: [
                        Tab(
                          height: 35,
                          text: "법인카드",
                        ),
                        Tab(
                          height: 35,
                          text: '영수증',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget getPage(context, controller, index) {
  //   switch (index) {
  //     case 0:
  //       return cardPage(context, controller);
  //     case 1:
  //       return receiptPage(context, controller);
  //     default:
  //       return Container();
  //   }
  // }

  Widget cardPage(context, _) {
    return Card(
      // margin: EdgeInsets.fromLTRB(10, 00, 10, 20),
      margin: EdgeInsets.all(10.0),

      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          )),
      child: Stack(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5),
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_left,
                          color: Colors.grey.shade400, size: 30.0),
                    ),
                  ),
                  Text(
                    "2022년 2월",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_right,
                        color: Colors.grey.shade400,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 50,
              ),
              padding: EdgeInsets.symmetric(
                // vertical: 30.0,
                horizontal: 30,
              ),
              width: 400,
              height: 300,
              child: Stack(
                children: [
                  SfRadialGauge(
                    animationDuration: 1000,
                    enableLoadingAnimation: true,
                    axes: <RadialAxis>[
                      RadialAxis(
                          radiusFactor: 0.8,
                          // startAngle: 180,
                          // endAngle: 0,
                          interval: 1000000,
                          canScaleToFit: false,
                          minimum: 0,
                          maximum: 2000000,
                          pointers: <GaugePointer>[
                            RangePointer(
                              value: _.cardAmt.toDouble(),
                              animationDuration: 1000,
                              color: Theme.of(context).primaryColor,
                              width: 40,
                            ),
                            WidgetPointer(
                                value: _.cardAmt.toDouble(),
                                child: Container(
                                    height: 55,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(15),
                                      // border: Border.all(
                                      //   color: Colors.black,
                                      //   style: BorderStyle.solid,
                                      //   width: 1.0)
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 2, 0, 0),
                                          child: Container(
                                            child: Text('${_.cardAmt}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 9)),
                                          ),
                                        )
                                      ],
                                    ))),
                            MarkerPointer(
                              color: Colors.black.withOpacity(0.5),
                              markerOffset: 15,
                              value: _.cardAmt.toDouble(),
                            )
                          ],
                          labelFormat: '₩{value}',
                          showLabels: false,
                          showTicks: true,
                          axisLineStyle: AxisLineStyle(
                            thickness: 40.0,
                            color: Colors.grey.shade300,
                          ),
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Container(
                                    child: Text('${(_.cardAmt / 20000).toStringAsFixed(2)}%',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold))),
                                angle: 90,
                                positionFactor: 0.1)
                          ]),
                    ],
                  ),
                  Container(
                    alignment: FractionalOffset(0.5, 0.95),
                    child: Text(
                      '사용 ₩${StringUtil.getStringAmount(_.cardAmt)}\n한도 ₩2,000,000',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: FractionalOffset(0.5, 0.95),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getCntBox(context, remain, '${_.cardPendCount}'),
                  getCntBox(context, proceed, '${_.cardProgressCount}'),
                  getCntBox(context, complete, '${_.cardCompleteCount}'),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            )
          ]),
    );
  }

  Widget receiptPage(context, _) {
    return Card(
      // margin: EdgeInsets.fromLTRB(10, 00, 10, 50),
      margin: EdgeInsets.all(10.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          )),
      child: Stack(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5),
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_left,
                          color: Colors.grey.shade400, size: 30.0),
                    ),
                  ),
                  Text(
                    "2022년 2월",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_right,
                        color: Colors.grey.shade400,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 50,
              ),
              padding: EdgeInsets.symmetric(
                // vertical: 10.0,
                horizontal: 30,
              ),
              width: 400,
              height: 300,
              child: Stack(
                children: [
                  SfRadialGauge(
                    animationDuration: 1000,
                    enableLoadingAnimation: true,
                    axes: <RadialAxis>[
                      RadialAxis(
                        radiusFactor: 0.8,
                        // startAngle: 180,
                        // endAngle: 0,
                        interval: 100000,
                        canScaleToFit: false,
                        minimum: -1,
                        maximum: double.parse('${_.receiptAmt}'),
                        pointers: <GaugePointer>[
                          RangePointer(
                            value: double.parse('${_.receiptCompleteAmt}'),
                            animationDuration: 1000,
                            color: Theme.of(context).primaryColor,
                            width: 40,
                          ),
                          WidgetPointer(
                              value: _.receiptCompleteAmt.toDouble(),
                              child: Container(
                                  height: 55,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(15),
                                    // border: Border.all(
                                    //   color: Colors.black,
                                    //   style: BorderStyle.solid,
                                    //   width: 1.0)
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 2, 0, 0),
                                        child: Container(
                                          child: Text(
                                              '${(_.receiptCompleteAmt)}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 9)),
                                        ),
                                      )
                                    ],
                                  ))),
                          MarkerPointer(
                            color: Colors.black.withOpacity(0.5),
                            markerOffset: 15,
                            value: _.receiptCompleteAmt.toDouble(),
                          )
                        ],
                        labelFormat: '₩{value}',
                        showLabels: false,
                        showTicks: true,
                        axisLineStyle: AxisLineStyle(
                          thickness: 40.0,
                          color: Colors.grey.shade300,
                        ),
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                              widget: Container(
                                  child: Text(
                                      '${((_.receiptCompleteAmt / _.receiptAmt) * 100).toStringAsFixed(2)}%',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))),
                              angle: 90,
                              positionFactor: 0.1)
                        ],
                      ),
                    ],
                  ),
                  Container(
                    alignment: FractionalOffset(0.5, 0.95),
                    child: Text(
                      '사용 ₩${StringUtil.getStringAmount(_.receiptAmt)}\n입금 ₩${StringUtil.getStringAmount(_.receiptCompleteAmt)}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: FractionalOffset(0.5, 0.95),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getCntBox(context, remain, '${_.receiptPendCount}'),
                  getCntBox(context, proceed, '${_.receiptProgressCount}'),
                  getCntBox(context, complete, '${_.receiptCompleteCount}'),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            )
          ]),
    );
  }

  Widget getCntBox(BuildContext context, String title, String value) {
    Color cntBoxColor = Theme.of(context).primaryColor.withOpacity(0.9);
    Color cntTextColor = Colors.white;
    double cntWidth = MediaQuery.of(context).size.width / 5;
    double cntHeight = 65;

    return Card(
      elevation: 2,
      color: cntBoxColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        width: cntWidth,
        height: cntHeight,
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: cntTextColor,
              ),
            ),
            Divider(
              height: 10,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 9,
                color: cntTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
