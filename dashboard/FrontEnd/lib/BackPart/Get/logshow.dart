// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class logshow extends GetxController {
  var showlist = [];
  bool startorstop = Hive.box('user_setting').get('startorstop') ?? true;

  ///setLogs
  ///
  ///로그리스트 보여주기
  void setLogs(what) {
    showlist = what;
    update();
    notifyChildrens();
  }

  ///setmodelprocess
  ///
  ///model start/stop 결정
  void setmodelprocess(bool what) {
    startorstop = what;
    Hive.box('user_setting').put('startorstop', startorstop);
    update();
    notifyChildrens();
  }
}
