// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:get/get.dart';

class logshow extends GetxController {
  var showlist = [];

  void setLogs(what) {
    ///setLogs
    ///
    ///로그리스트 보여주기

    showlist = what;
    update();
    notifyChildrens();
  }
}
