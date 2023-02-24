// ignore_for_file: non_constant_identifier_names

import 'package:app/BackPart/Get/drawing.dart';
import 'package:app/FrontPart/Pages/MainPage.dart';
import 'package:app/FrontPart/Route/Splash.dart';
import 'package:app/Tools/MyTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Tools/Platform.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'Detector',
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAZYwT4HVx0093UsQTY7z168QZjHLQ-qbs',
          appId: '1:417460115007:web:d2418302bcc6b285b60a8a',
          messagingSenderId: '417460115007',
          projectId: 'anomaly-detector-78c11'));

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
            title: 'Solution',
          ),
          initialRoute: '/',
          getPages: [
            GetPage(name: '/home', page: () => const MainPage()),
          ],
        ),
        GetCupertinoApp(
          debugShowCheckedModeBanner: false,
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('ko', 'KR'),
          home: const SplashPage(
            title: 'Solution',
          ),
          initialRoute: '/',
          getPages: [
            GetPage(name: '/home', page: () => const MainPage()),
          ],
        ),
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('ko', 'KR'),
          home: const SplashPage(
            title: 'Solution',
          ),
          initialRoute: '/',
          getPages: [
            GetPage(name: '/home', page: () => const MainPage()),
          ],
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
