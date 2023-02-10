import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:exps_app/card/model/card_data.dart';
import "package:get/get.dart";
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

class CardDetail extends StatefulWidget {
  const CardDetail({Key? key}) : super(key: key);

  @override
  _CardDetailState createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  @override
  Widget build(BuildContext context) {
    CardData data = Get.arguments['data'];
    double rowHeight = 5;

    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            floating: false,
            title: Text(
              '상세 사용내역',
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              GestureDetector(
                onHorizontalDragUpdate: (details){
                  if (details.primaryDelta! > 0) {
                    Get.back();
                  }
                },
                child: Card(
                  elevation: 4.0,
                  color: Colors.white,
                  shadowColor: Colors.grey.shade400,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('${Get.arguments['data'].getApprDt()}'),
                            ],
                          ),
                        ),
                        Divider(color: Colors.black26, height: 24.0, thickness: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${Get.arguments['data'].merchant}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              )
                            ),
                          ],
                        ),
                        Text(
                            '${Get.arguments['data'].getStringApprTot()} 원',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        SizedBox(height: 50,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            title('카드번호'),
                            Text('${data.cardNo}'),
                          ],
                        ),
                        SizedBox(height: rowHeight),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            title('승인번호'),
                            Text('${Get.arguments['data'].apprNo}'),
                          ],
                        ),
                        SizedBox(height: rowHeight,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            title('거래유형'),
                            Text('승인'),
                          ],
                        ),
                        Divider(color: Colors.black26, height: 36.0, thickness: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            title('공급가액'),
                            Text('${Get.arguments['data'].getStringApprAmt()}'),
                          ],
                        ),
                        SizedBox(height: rowHeight,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            title('부가세액'),
                            Text('${Get.arguments['data'].getStringVat()}'),
                          ],
                        ),
                        SizedBox(height: rowHeight,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            title('봉사료'),
                            Text('${Get.arguments['data'].getStringServiceCharge()}'),
                          ],
                        ),
                        Divider(color: Colors.black26, height: 36.0, thickness: 2),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                title('가맹점명'),
                                Text('${data.merchant}', overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                            SizedBox(height: rowHeight,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                title('사업자번호'),
                                Text('1234567890'),
                              ],
                            ),
                            SizedBox(height: rowHeight,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                title('업종'),
                                Text('업종1'),
                              ],
                            ),
                            SizedBox(height: rowHeight,),
                            title('가맹점주소'),
                            Text('${Get.arguments['data'].merchantAddr}, ', overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 13.0
                            )),
                            SizedBox(height: 15,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                    AlertDialog(
                                      contentPadding: EdgeInsets.only(
                                        left: 0.0,
                                        top: 0.0,
                                        right: 7.0,
                                        bottom: 7.0,
                                      ),
                                      alignment: Alignment.center,
                                      insetPadding: EdgeInsets.all(0.0),

                                      content: Container(
                                        color: Colors.black.withOpacity(0.5),
                                        height: 250,
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              height: 250,
                                              width: MediaQuery.of(context).size.width * 0.9,
                                              left: 0,
                                              top: 0,
                                              child: Container(
                                                child: WebViewWidget(controller: controller),
                                              ),
                                            ),
                                            Positioned(
                                              left: 10,
                                              top: 10,
                                              child: InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child:
                                                    Container(
                                                      color: Colors.white.withOpacity(0.6),
                                                      padding: EdgeInsets.all(5),
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                      )
                                                    )
                                              )
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                );
                              },
                              child: Text('위치보기', style: TextStyle(fontSize: 13.0,
                              ),),
                            ),
                            SizedBox(height: 15,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ])
          )
        ],
      ),
    );
  }

  // Row getMapText(context, index) {
  //   return Row(
  //     children: [
  //       Text(
  //         mapText[index],
  //         style: TextStyle(
  //           color: Theme.of(context).primaryColor,
  //           decoration: TextDecoration.underline,
  //           decorationStyle: TextDecorationStyle.dotted,
  //           decorationThickness: 1,
  //           fontSize: 12.0,
  //         ),
  //       ),
  //       // Icon(mapIcon[index], size: 12.0,),
  //     ],
  //   );
  // }

  Container title(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}
