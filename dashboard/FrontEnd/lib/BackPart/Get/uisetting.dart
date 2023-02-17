// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Enum/modelinsights.dart';

class uisetting extends GetxController {
  int pagenumber = 0;
  bool auto = Hive.box('user_setting').get('isauto') ?? false;
  int key = 1;
  int tmpkey = 1;
  int threshold = 1;
  String imgshow = '';
  List<modelinsights> modelinsightslist = [];
  double maxy = 0.0;
  double defaulty = 0.0;
  List<modelinsights> insightstap = [];
  int listx = 0;

  ///setPagenumber
  ///
  ///페이지 라우트 결정
  void setPagenumber(int what) {
    pagenumber = what;
    update();
    notifyChildrens();
  }

  ///setautoreload
  ///
  ///메인보드 자동리로드 결정
  void setautoreload(bool what) {
    auto = what;
    Hive.box('user_setting').put('isauto', auto);
    update();
    notifyChildrens();
  }

  ///setmodelprocess
  ///
  ///model start/stop 결정
  void setKey(int what) {
    key = what;
    Hive.box('user_setting').put('isclickkeychange', true);
    update();
    notifyChildrens();
  }

  ///setmodelprocess
  ///
  ///model start/stop 결정
  void settmpKey(int what) {
    tmpkey = what;
    update();
    notifyChildrens();
  }

  ///setmodelprocess
  ///
  ///model start/stop 결정
  void setThreshold(int what) {
    threshold = what;
    update();
    notifyChildrens();
  }

  ///setdbimgshow
  ///
  ///SummaryModel 이미지 결정
  void setdbimgshow(String what) {
    imgshow = what;
    update();
    notifyChildrens();
  }

  ///setinsights
  ///
  ///model insights list 채우기
  void setinsights(what) {
    modelinsightslist.add(what);
    update();
    notifyChildrens();
  }

  ///setinsights
  ///
  ///model insights list 비우기
  void resetinsights() {
    modelinsightslist.clear();
    update();
    notifyChildrens();
  }

  ///setdefaulty
  ///
  ///defaulty 결정
  void setdefaulty(double what) {
    defaulty = what;
    update();
    notifyChildrens();
  }

  ///resetlistx
  ///
  ///listx 초기화
  void resetlistx() {
    listx = 0;
    update();
    notifyChildrens();
  }
}
