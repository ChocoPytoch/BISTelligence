// ignore_for_file: camel_case_types, implementation_imports

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

class modelinsights {
  final int x;
  final double y;

  modelinsights({required this.x, required this.y});
}

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
        if (uiset.auto) {
          //중단
          GetProcess('auto-stop');
          //시행
          GetProcess('auto-start');
          if (Hive.box('user_setting').get('startorstop')) {
            if (uiset.key == 6) {
              uiset.settmpKey(1);
              uiset.setKey(1);
            } else {
              uiset.key = uiset.key + 1;
              uiset.settmpKey(uiset.key);
              uiset.setKey(uiset.key);
            }
            uiset.setdefaulty(0.0);
            uiset.resetinsights();
            uiset.resetlistx();
          } else {}
        } else {
          //중단
          GetProcess('notauto-stop');
        }
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
