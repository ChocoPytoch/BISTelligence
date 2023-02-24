// ignore_for_file: non_constant_identifier_names

import 'package:app/BackPart/Get/logshow.dart';
import 'package:get/get.dart';
import '../BackPart/Firebase/Streams.dart';

final logging = Get.put(logshow());

GetBack() {
  Get.back();
}

GetProcess(string) {
  print(string);
  logging.setmodelprocess(!logging.startorstop);
  SaveLogs();
}
