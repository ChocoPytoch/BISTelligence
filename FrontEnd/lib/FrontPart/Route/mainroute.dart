// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:app/BackPart/Get/drawing.dart';
import 'package:app/BackPart/Get/uisetting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Pages/MainPage.dart';

class mainroute extends StatefulWidget {
  ///mainroute
  ///
  ///이 곳은 추후 페이지 이동을 가능하게 해주는 라우트 공간이다.
  const mainroute({Key? key}) : super(key: key);
  @override
  State<mainroute> createState() => _mainrouteState();
}

class _mainrouteState extends State<mainroute> {
  ///변수 선언구간
  final draw = Get.put(drawing());
  final uiset = Get.put(uisetting());

  List pages = [
    const MainPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<drawing>(
        builder: (_) => GetBuilder<uisetting>(builder: ((_) {
              return Scaffold(
                backgroundColor: draw.backgroundcolor,
                body: pages[uiset.pagenumber],
              );
            })));
  }
}
