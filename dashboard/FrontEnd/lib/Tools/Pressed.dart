// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../BackPart/Get/uisetting.dart';
import 'Variables.dart';

final uiset = Get.put(uisetting());

GetBack() {
  Get.back();
}

GetProcess() {
  if (uiset.startorstop) {
    uiset.setmodelprocess(false);
  } else {
    uiset.setmodelprocess(true);
  }
  Get.back();
  SaveLogs();
}

SaveLogs() async {
  await firestore.collection('Log').add({
    'Status': uiset.startorstop ? 'Stop' : 'Running',
    'Date':
        '${DateFormat('yyyy-MM-dd hh:mm').parse(DateTime.now().toString()).toString().split(' ')[0]} ${DateFormat('yyyy-MM-dd hh:mm').parse(DateTime.now().toString()).toString().split(' ')[1].split(':')[0]}:${DateFormat('yyyy-MM-dd hh:mm').parse(DateTime.now().toString()).toString().split(' ')[1].split(':')[1]}'
  });
}
