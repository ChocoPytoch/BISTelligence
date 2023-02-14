// ignore_for_file: non_constant_identifier_names, file_names

import 'package:app/BackPart/Get/uisetting.dart';
import 'package:app/Tools/MyTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Tools/ContainerDesign.dart';
import '../../Tools/Pressed.dart';

final uiset = Get.put(uisetting());

OSDialog(title, content) {
  return AlertDialog(
    backgroundColor: MyTheme.chartcolor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    title: Text(title,
        style:
            title == 'Warning' ? MyTheme.WarningText : MyTheme.bigcontentText),
    content: content,
    scrollable: true,
  );
}

ModelLogDialog() {
  Get.dialog(LayoutBuilder(
    builder: (context, constraint) {
      return OSDialog(
        '작동원리가 궁금하신가요?',
        SizedBox(
          width: constraint.maxWidth * 0.3,
          height: constraint.maxWidth * 0.5 < 300 && GetPlatform.isWeb
              ? constraint.maxHeight * 0.4
              : constraint.maxHeight * 0.2,
          child: Column(children: [
            Container(
              height: 2,
              color: Colors.black45,
            ),
            Flexible(
                fit: FlexFit.tight,
                child: SingleChildScrollView(
                  child: Text(
                    '버튼을 통해 제조설비의 Start/Stop 상태를 보다 직관적이고 빠르게 결정할 수 있습니다.',
                    style: MyTheme.smallcontentText,
                    textAlign: TextAlign.start,
                  ),
                )),
            Container(
              height: 2,
              color: Colors.black45,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: constraint.maxWidth * 0.5 * 0.3,
                child: GestureDetector(
                  onTap: () {
                    GetBack();
                  },
                  child: ContainerDesign(
                      color: MyTheme.colorwhite,
                      child: SizedBox(
                        child: Text(
                          '닫기',
                          style: MyTheme.insidecontainerText,
                          textAlign: TextAlign.center,
                        ),
                      )),
                ))
          ]),
        ),
      );
    },
  ));
}

StartOrStop() {
  Get.dialog(LayoutBuilder(
    builder: (context, constraint) {
      return GetBuilder<uisetting>(builder: (_) {
        return OSDialog(
          'Warning',
          SizedBox(
            width: constraint.maxWidth * 0.3,
            height: constraint.maxWidth * 0.5 < 300 && GetPlatform.isWeb
                ? constraint.maxHeight * 0.4
                : constraint.maxHeight * 0.2,
            child: Column(children: [
              Container(
                height: 2,
                color: Colors.black45,
              ),
              Flexible(
                  fit: FlexFit.tight,
                  child: SingleChildScrollView(
                    child: Text(
                      uiset.startorstop
                          ? '현재 중단된 공정을 다시 시작하시겠습니까?'
                          : '현재 진행중인 공정을 중단시키시겠습니까?',
                      style: MyTheme.smallcontentText,
                      textAlign: TextAlign.start,
                    ),
                  )),
              Container(
                height: 2,
                color: Colors.black45,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: constraint.maxWidth * 0.5 * 0.3,
                  child: GestureDetector(
                    onTap: () {
                      GetProcess();
                    },
                    child: ContainerDesign(
                        color: MyTheme.colorwhite,
                        child: SizedBox(
                          child: Text(
                            uiset.startorstop ? 'Start' : 'Stop',
                            style: MyTheme.insidecontainerText,
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ))
            ]),
          ),
        );
      });
    },
  ));
}
