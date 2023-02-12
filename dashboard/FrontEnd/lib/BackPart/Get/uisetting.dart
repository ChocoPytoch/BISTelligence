// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:get/get.dart';

class uisetting extends GetxController {
  int pagenumber = 0;
  int summarylistnumber = 0;
  int key = 1;
  int tmpkey = 1;
  int threshold = 1;
  bool startorstop = false;

  void setPagenumber(int what) {
    ///setPagenumber
    ///
    ///페이지 라우트 결정

    pagenumber = what;
    update();
    notifyChildrens();
  }

  void setSummarylistnumber(int what) {
    ///setSummarylistnumber
    ///
    ///Summarylist 페이지 뷰 결정

    summarylistnumber = what;
    update();
    notifyChildrens();
  }

  void setmodelprocess(bool what) {
    ///setmodelprocess
    ///
    ///model start/stop 결정

    startorstop = what;
    update();
    notifyChildrens();
  }

  void setKey(int what) {
    ///setmodelprocess
    ///
    ///model start/stop 결정

    key = what;
    update();
    notifyChildrens();
  }

  void settmpKey(int what) {
    ///setmodelprocess
    ///
    ///model start/stop 결정

    tmpkey = what;
    update();
    notifyChildrens();
  }

  void setThreshold(int what) {
    ///setmodelprocess
    ///
    ///model start/stop 결정

    threshold = what;
    update();
    notifyChildrens();
  }
}
