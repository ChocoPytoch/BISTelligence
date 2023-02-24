// ignore_for_file: camel_case_types, implementation_imports

import 'package:get/get.dart';
import '../Get/logshow.dart';
import '../Get/uisetting.dart';

final uiset = Get.put(uisetting());
final logging = Get.put(logshow());

class modelinsights {
  final int x;
  final double y;

  modelinsights({required this.x, required this.y});
}
