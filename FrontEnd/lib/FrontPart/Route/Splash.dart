// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:get/get.dart';
import 'mainroute.dart';

///앱 백그라운드에서 데이터를 불러올 동안 스플래시 스크린에 머물게 하고
///이후에 메인페이지로 이동하게 하는 코드.
///
///현재는 임의로 3초로 설정.
GoToMain() {
  Timer(const Duration(seconds: 3), () {
    Get.offNamed('/home');
  });
}
