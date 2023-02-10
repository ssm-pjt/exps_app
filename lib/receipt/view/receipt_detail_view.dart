import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:exps_app/receipt/model/receipt_data.dart';
import 'package:exps_app/receipt/view/receipt_photo_view.dart';
import "package:get/get.dart";

class ReceiptDetail extends StatelessWidget {
  const ReceiptDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReceiptData data = Get.arguments['data'];

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details){
          if (details.primaryDelta! > 0) {
            Get.back();
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              title: Text(
                '상세 사용내역',
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Card(
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
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xff999999),
                                width: 3.0,
                              )
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('${Get.arguments['data'].getApprDt()}'),
                              SizedBox(width: 5 ,),
                              // Text('${Get.arguments['data'].getApprTm()}'),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${Get.arguments['data'].account}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
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
                        Text(
                            '${Get.arguments['data'].comment} ',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            )
                        ),
                      ],
                    ),
                  ),
                )
              ])
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  child: Card(
                    color: Colors.grey.shade100,
                    margin: EdgeInsets.all(0.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                                () => PhotoView(encodedImage: data.image, index: index),
                              transition: Transition.zoom
                            );
                          },
                          child: Image.memory(
                            base64Decode(data.image[index]),
                            fit: BoxFit.cover,
                          ),
                        )
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 2,
                  ),
                ),
                childCount: data.image.length,

              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // mainAxisSpacing: 1.0,
                childAspectRatio: 1,
                crossAxisCount: 2,

              ),

            )
          ],
        ),
      ),
    );
  }

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


