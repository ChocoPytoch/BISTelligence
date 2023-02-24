// ignore_for_file: non_constant_identifier_names, file_names

import 'package:app/BackPart/Get/uisetting.dart';
import 'package:app/Tools/MyTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Tools/ContainerDesign.dart';
import '../../Tools/Pressed.dart';
import '../UI/MainUI.dart';

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
        Container(
            constraints: BoxConstraints(
              minWidth: constraint.maxWidth * 0.3,
              minHeight: (GetPlatform.isWeb || Get.height > 400
                  ? constraint.maxHeight * 0.3
                  : constraint.maxHeight * 0.6),
            ),
            child: SizedBox(
              width: constraint.maxWidth * 0.5,
              height: (GetPlatform.isWeb || Get.height > 400
                  ? constraint.maxHeight * 0.3
                  : constraint.maxHeight * 0.6),
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
            )),
      );
    },
  ));
}

/*
StartOrStop() {
  Get.dialog(LayoutBuilder(
    builder: (context, constraint) {
      return GetBuilder<uisetting>(builder: (_) {
        return OSDialog(
          'Warning',
          Container(
              constraints: BoxConstraints(
                minWidth: constraint.maxWidth * 0.3,
                minHeight: (GetPlatform.isWeb || Get.height > 400
                    ? constraint.maxHeight * 0.3
                    : constraint.maxHeight * 0.6),
              ),
              child: SizedBox(
                width: constraint.maxWidth * 0.5,
                height: (GetPlatform.isWeb || Get.height > 400
                    ? constraint.maxHeight * 0.3
                    : constraint.maxHeight * 0.6),
                child: Column(children: [
                  Container(
                    height: 2,
                    color: Colors.black45,
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      child: SingleChildScrollView(
                        child: Text(
                          logging.startorstop
                              ? '현재 진행중인 공정을 중단시키시겠습니까?'
                              : '현재 중단된 공정을 다시 시작하시겠습니까?',
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
                      width: constraint.maxWidth * 0.3,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          GetProcess('dialog');
                        },
                        child: ContainerDesign(
                            color: MyTheme.colorwhite,
                            child: SizedBox(
                              child: Text(
                                logging.startorstop ? 'Stop' : 'Start',
                                style: MyTheme.insidecontainerText,
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ))
                ]),
              )),
        );
      });
    },
  ));
}
*/
PlotDialog() {
  Get.dialog(LayoutBuilder(
    builder: (context, constraint) {
      return OSDialog(
        '구간 선택',
        Container(
            constraints: BoxConstraints(
              minWidth: constraint.maxWidth * 0.3,
              minHeight: (GetPlatform.isWeb || Get.height > 400
                  ? constraint.maxHeight * 0.3
                  : constraint.maxHeight * 0.6),
            ),
            child: SizedBox(
              width: constraint.maxWidth * 0.5,
              height: (GetPlatform.isWeb || Get.height > 400
                  ? constraint.maxHeight * 0.3
                  : constraint.maxHeight * 0.6),
              child: Column(children: [
                Container(
                  height: 2,
                  color: Colors.black45,
                ),
                Flexible(
                    fit: FlexFit.tight,
                    child: SingleChildScrollView(
                      child: Text(
                        '원인분석을 하고자 하는 구간선택을 하셔야 합니다. 확인 버튼을 클릭하시고 메인 대시보드에서 구간을 클릭하실 수 있습니다.',
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
                        uiset.setdbimgshow('pause');
                      },
                      child: ContainerDesign(
                          color: MyTheme.colorwhite,
                          child: SizedBox(
                            child: Text(
                              '확인',
                              style: MyTheme.insidecontainerText,
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ))
              ]),
            )),
      );
    },
  ));
}

ImgDialog() {
  Get.dialog(LayoutBuilder(
    builder: (context, constraint) {
      return OSDialog(
        '분석결과',
        Container(
            constraints: BoxConstraints(
              minWidth: constraint.maxWidth * 0.3,
              minHeight: (GetPlatform.isWeb || Get.height > 400
                  ? constraint.maxHeight * 0.5
                  : constraint.maxHeight * 0.6),
            ),
            child: SizedBox(
              width: constraint.maxWidth * 0.5,
              height: (GetPlatform.isWeb || Get.height > 400
                  ? constraint.maxHeight * 0.5
                  : constraint.maxHeight * 0.6),
              child: Column(children: [
                Container(
                  height: 2,
                  color: Colors.black45,
                ),
                Flexible(
                    fit: FlexFit.tight,
                    child: SingleChildScrollView(
                      child: Image.network(
                        uiset.imgurl,
                        fit: BoxFit.contain,
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
                              '확인',
                              style: MyTheme.insidecontainerText,
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ))
              ]),
            )),
      );
    },
  ));
}
