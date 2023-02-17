// ignore_for_file: non_constant_identifier_names

import 'package:app/BackPart/Enum/LogFile.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Tools/Variables.dart';
import '../Get/logshow.dart';

final logging = Get.put(logshow());

///이 아래는 StreamBuilder기반 코드 작성
PageViewStreamParent1() {
  return firestore.collection('Log').snapshots();
}

PageViewRes1_1(snapshot) {
  logging.showlist.clear();
  final valuespace = snapshot.data!.docs;
  for (var sp in valuespace) {
    logging.showlist
        .add(LogFile(title: sp.get('Status'), date: sp.get('Date')));
  }
  logging.showlist.sort(((a, b) {
    return b.date.compareTo(a.date);
  }));
}

SaveLogs() {
  firestore.collection('Log').add({
    'Status': logging.startorstop ? 'Running' : 'Stop',
    'Date':
        '${DateFormat('yyyy-MM-dd hh:mm').parse(DateTime.now().toString()).toString().split(' ')[0]} ${DateFormat('yyyy-MM-dd hh:mm').parse(DateTime.now().toString()).toString().split(' ')[1].split(':')[0]}:${DateFormat('yyyy-MM-dd hh:mm').parse(DateTime.now().toString()).toString().split(' ')[1].split(':')[1]}'
  });
}
