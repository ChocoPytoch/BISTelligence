// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:app/BackPart/Enum/keyitems.dart';
import 'package:app/Tools/Variables.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Enum/modelinsights.dart';

class uisetting extends GetxController {
  int pagenumber = 0;
  final connect = GetConnect();
  bool auto = Hive.box('user_setting').get('isauto') ?? false;
  int key = 1;
  int tmpkey = 1;
  int threshold = 1;
  String imgshow = '';
  String imgurl = '';
  List<double> score_list = [];
  List<modelinsights> modelinsightslist = [];
  double maxy = 0.0;
  double miny = 0.0;
  double defaulty = 0.0;
  List<modelinsights> insightstap = [];
  int listx = 0;
  bool loading = false;
  String status = '';
  bool bigimg = false;
  String successconnect = '';

  ///setPagenumber
  ///
  ///페이지 라우트 결정
  void setPagenumber(int what) {
    pagenumber = what;
    update();
    notifyChildrens();
  }

  ///setBigimg
  ///
  ///큰 이미지 볼지 결정
  void setBigimg(bool what) {
    bigimg = what;
    update();
    notifyChildrens();
  }

  ///scorelistfetch
  ///
  ///메인보드 리스트 상태변경
  void scorelistfetch(double what) async {
    score_list.add(what);
    update();
    notifyChildrens();
  }

  ///fetchlist
  ///
  ///서버에서 healthindex값을 리스트로 불러옴
  Future fetchlist() async {
    String starturl = GetPlatform.isWeb
        ? 'http://localhost:8000/data/ScoreUpdate'
        : 'http://10.0.2.2:8000/data/ScoreUpdate';
    if (uiset.score_list.isEmpty) {
      var params = {
        'Key': key,
      };
      Response response = await connect.request(starturl, 'get',
          headers: <String, String>{
            'Accept': 'application/json',
            'Access-Control-Allow-Headers': '*'
          },
          body: jsonEncode(params));
      if (response.statusCode == 200 || response.statusCode == 201) {
        for (int i = 0; i < response.body.length; i++) {
          uiset.scorelistfetch(response.body[i]['Score']);
        }
      } else {
        throw Exception('fail');
      }
    } else {}
  }

  ///BackgroundloadImage
  ///
  ///서버에서 모델로부터 이미지를 저장하게 함
  Future BackgroundloadImage() async {
    String starturl = GetPlatform.isWeb
        ? 'http://localhost:8000/xai/PlotUpdate'
        : 'http://10.0.2.2:8000/xai/PlotUpdate';
    var params = imgshow == 'sp'
        ? {
            'key': key,
            'threshold': defaulty,
            'index': modelinsightslist.length - 1,
          }
        : {
            'key': key,
            'threshold': defaulty,
            'index': insightstap[0].x,
          };
    Response response = await connect.request(starturl, 'get',
        headers: <String, String>{
          'Accept': 'application/json',
        },
        body: jsonEncode(params));
    update();
    notifyChildrens();
  }

  ///FetchImage
  ///
  ///서버에서 모델로부터 이미지를 불러오게 함
  Stream FetchImage() async* {
    String starturl = GetPlatform.isWeb
        ? 'http://localhost:8000/xai'
        : 'http://10.0.2.2:8000/xai';
    Response response = await connect.get(starturl);
    if (response.statusCode == 200 || response.statusCode == 201) {
      status = '';
    } else if (response.statusCode == 500) {
      status = 'Bad Request';
    }
    if (response.body.isEmpty) {
      Future.delayed(const Duration(seconds: 2), () {
        FetchImage();
        successconnect = 'loading';
        update();
        notifyChildrens();
      });
    } else {
      successconnect = 'success';
    }
    yield response.body;
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

  ///setKey
  ///
  ///서버에 전달할 key값 결정
  void setKey(int what) {
    key = what;
    Hive.box('user_setting').put('isclickkeychange', true);
    update();
    notifyChildrens();
  }

  ///settmpKey
  ///
  ///key값의 변화 핸들링
  void settmpKey(int what) {
    tmpkey = what;
    update();
    notifyChildrens();
  }

  ///setThreshold
  ///
  ///서버에 전달할 threshold값 결정
  void setThreshold(int what) {
    threshold = what;
    update();
    notifyChildrens();
  }

  ///setdbimgshow
  ///
  ///SummaryModel 이미지 결정(summary : sp, force : fp, etc : '')
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

  ///resetinsights
  ///
  ///model insights list 비우기
  void resetinsights() {
    modelinsightslist.clear();
    update();
    notifyChildrens();
  }

  ///setmaxy
  ///
  ///maxy 결정
  void setmaxy(double what) {
    maxy = what;
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
