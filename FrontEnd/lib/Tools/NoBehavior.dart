// ignore_for_file: unnecessary_overrides
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///NoBehavior
///
///스크롤 뷰에서 상하부 모션을 삭제해줌.
class NoBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return super.buildOverscrollIndicator(context, child, details);
  }
}
