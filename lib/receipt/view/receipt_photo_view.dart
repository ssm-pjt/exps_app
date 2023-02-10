import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoView extends StatefulWidget {
  PhotoView({Key? key, required this.encodedImage, required this.index}) : super(key: key);

  final List<String> encodedImage;
  final int index;


  @override
  State<PhotoView> createState() => _ReceiptPhotoViewState();
}

class _ReceiptPhotoViewState extends State<PhotoView> {
  late final PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: PageView.builder(
          physics: BouncingScrollPhysics(),
          controller: pageController,
          itemCount: widget.encodedImage.length,
          itemBuilder: (context, index)
          => Stack(children: <Widget>[
              InteractiveViewer(
                maxScale: 5.0,
                minScale: 0.3,
                clipBehavior: Clip.none,
                panEnabled: true,
                child: Container(
                  color: Colors.black,
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.memory(
                    base64Decode(widget.encodedImage[index]),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                  top: 5.0,
                  left: 5.0,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        color: Colors.white.withOpacity(0.5),
                        child: Icon(
                          Icons.close,
                          size: 40,
                          color: Colors.black,
                        )),
                  )),
            ]),
        ),
        
      
    );
  }
}