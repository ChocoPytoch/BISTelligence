// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names, unused_local_variable

import 'dart:async';
import 'package:get/get.dart';
import '../../BackPart/Get/logshow.dart';
import '../../BackPart/Get/uisetting.dart';

Future initialLoading() async {
  final uiset = Get.put(uisetting());
  final logging = Get.put(logshow());

  // 제조설비의 동작상태를 로딩 시에 적용
  uiset.startorstop =
      logging.showlist.isEmpty || logging.showlist[0].title == 'Running'
          ? false
          : true;
}
