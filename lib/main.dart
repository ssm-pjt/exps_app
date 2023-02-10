import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exps_app/bindings.dart';
import 'package:get/get.dart';
import 'dart:io';

import './router.dart' as pages;
import './style.dart' as ecbankstyle;
import 'login/view/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  //세로모드만 지원
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var map = androidInfo.toMap();

    map.forEach((key, value) {
      print('${key}: ${value}');
    });
  } else if (Platform.isIOS) {
    IosDeviceInfo info = await deviceInfo.iosInfo;
    var map = info.toMap();

    map.forEach((key, value) {
      print('${key}: ${value}');
    });
  }

  runApp(EasyLocalization(
    supportedLocales: [
      Locale('en'),
      Locale('ko'),
    ],
    path: 'assets/translations',
    //fallbackLocale supportedLocales에 설정한 언어가 없는 경우 설정되는 언어
    fallbackLocale: Locale('en', 'ko'),
    //startLocale을 지정하면 초기 언어가 설정한 언어로 변경됨
    //만일 이 설정을 하지 않으면 OS 언어를 따라 기본 언어가 설정됨
    //startLocale: Locale('ko', 'KR')

    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // builder:
      //     (context, child) {
      //   return MediaQuery(
      //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      //     child: child!,
      //   );
      // },
      locale: context.locale,
      // 기본적으로 필요한 언어 설정
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      title: 'Ecbank E-business',
      home: LoginView(),
      debugShowCheckedModeBanner: false,
      theme: ecbankstyle.theme,
      themeMode: ThemeMode.light,
      getPages: pages.routePage(),
      initialBinding: GetBindings(),
    );
  }
}
