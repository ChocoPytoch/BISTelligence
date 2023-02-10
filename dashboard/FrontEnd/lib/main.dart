// ignore_for_file: non_constant_identifier_names

import 'package:app/BackPart/Get/drawing.dart';
import 'package:app/FrontPart/Route/Splash.dart';
import 'package:app/Tools/MyTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:status_bar_control/status_bar_control.dart';

import 'Tools/Platform.dart';

void main() async {
  ///WidgetsFlutterBinding.ensureInitialized()는 firebase를 동기화하기 위해 사용하는데 혹시 사용할 경우가 있을 수 있어 미리 선언
  WidgetsFlutterBinding.ensureInitialized();
  if (GetPlatform.isWeb) {
    await Firebase.initializeApp(
        name: 'Detect System',
        options: const FirebaseOptions(
            apiKey: 'AIzaSyAZYwT4HVx0093UsQTY7z168QZjHLQ-qbs',
            appId: '1:417460115007:web:d2418302bcc6b285b60a8a',
            messagingSenderId: '417460115007',
            projectId: 'anomaly-detector-78c11'));
  } else {
    await Firebase.initializeApp();
  }

  ///Hive.initFlutter()는 사용자 디바이스에 직접 저장되는 sqlite 형식의 저장방식을 선언하는 코드
  ///Hive.openBox('Here name')은 Hive의 박스이름을 지정하는 코드
  await Hive.initFlutter();
  await Hive.openBox('user_info');
  await Hive.openBox('user_setting');

  ///runApp으로 앱 시작
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ReturnByPlatform(
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('ko', 'KR'),
          home: const SplashPage(
            title: 'Anomaly Detector',
          ),
        ),
        GetCupertinoApp(
          debugShowCheckedModeBanner: false,
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('ko', 'KR'),
          home: const SplashPage(
            title: 'Anomaly Detector',
          ),
        ),
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('ko', 'KR'),
          home: const SplashPage(
            title: 'Anomaly Detector',
          ),
        ));
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.title});
  final String title;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  ///변수 선언구간
  final draw = Get.put(drawing());

  @override
  void initState() {
    super.initState();
    GoToMain();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///StatusBarControl.setColor(color, animated)를 통해 앱바의 색을 애니메이션 효과와 함께 변경
    StatusBarControl.setColor(draw.backgroundcolor, animated: true);
    return GetBuilder<drawing>(builder: (_) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: draw.backgroundcolor,
          body: SafeArea(
              child: SizedBox(
                  height: Get.height,
                  child: LayoutBuilder(
                    builder: ((context, constraint) {
                      return SplashView(constraint.maxHeight, widget.title);
                    }),
                  ))));
    });
  }
}

///SplashView
///
///앱 내부에서 데이터를 불러오기 전까지 띄우는 뷰
Widget SplashView(double maxHeight, String title) {
  return SizedBox(
    height: maxHeight,
    child: Center(
      child: Text(
        title,
        style: MyTheme.splashTitle,
      ),
    ),
  );
}
