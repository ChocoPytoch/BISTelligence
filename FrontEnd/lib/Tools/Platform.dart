// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

ReturnByPlatform(actionandroid, actionios, actionweb) {
  if (GetPlatform.isWeb) {
    return actionweb;
  } else {
    if (GetPlatform.isAndroid) {
      return actionandroid;
    } else {
      return actionios;
    }
  }
}
