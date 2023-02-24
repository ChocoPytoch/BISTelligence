// ignore_for_file: camel_case_types, implementation_imports

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:app/Tools/Pressed.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/src/chart/chart_series/series.dart';
import '../../Tools/Variables.dart';
import '../Get/logshow.dart';
import '../Get/uisetting.dart';

final uiset = Get.put(uisetting());
final logging = Get.put(logshow());

List<double> score_list = [];


Future<List> fetchList() async {
  final response =
  // https://127.0.0.1:8000/catalog
  // https://jsonplaceholder.typicode.com/posts/1
  await http.get('http://localhost:8000/data' as Uri);

  if (response.statusCode == 200) {
    // return Info.fromJson(json.decode(response.body));
    // return jsonDecode(utf8.decode(response.bodyBytes));
    List jsonResponse = jsonDecode(response.body);
    for (int i = 0; i< 300; i++){
      score_list.add(jsonResponse[i]['Score']);
    }
    //print(printScore());
    return score_list;
    //return jsonResponse.map((data) => Info.fromJson(data)).toList();
  } else {
    throw Exception('fail');
  }
}

List<double> printScore() {
  return score_list;
}

class modelinsights {
  final int x;
  final double y;

  modelinsights({required this.x, required this.y});
}

var list = fetchList();

refreshchart(ChartSeriesController? chartSeriesController, String s) {
  var modellist = [];
  if (s == 'pause') {
    Hive.box('user_setting').get('isfinished') == false;
  } else {
    Future.delayed(const Duration(seconds: 1), () {
      if (uiset.listx < keynum[uiset.key - 1]) {
        Hive.box('user_setting').put('isfinished', false);
        var rnd = Random().nextDouble() * 10;
        modellist.add(modelinsights(
            x: uiset.listx,
            y: uiset.listx <= keynum[uiset.key - 1] * 0.8 ? 0 : rnd));
        uiset.setinsights(modellist[0]);
        scrollthreshold();
        modelchartlive(chartSeriesController, uiset.modelinsightslist);
        uiset.listx += 1;
        modellist.clear();
      } else {
        Hive.box('user_setting').put('isfinished', true);
      }
    });
  }
}

scrollthreshold() {
  var tmplist = [];
  tmplist = List.from(uiset.modelinsightslist);
  tmplist.sort(((a, b) {
    return a.y.compareTo(b.y);
  }));
  uiset.maxy = tmplist[tmplist.length - 1].y;
}

modelchartlive(chartSeriesController, List<modelinsights> modelinsightslist) {
  chartSeriesController?.updateDataSource(
    addedDataIndexes: <int>[modelinsightslist.length - 1],
  );
}
