// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:async';
import 'dart:ui';
import 'package:app/BackPart/Get/logshow.dart';
import 'package:app/BackPart/Get/uisetting.dart';
import 'package:app/Tools/ContainerDesign.dart';
import 'package:app/Tools/Variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import '../../BackPart/Firebase/Streams.dart';
import '../../BackPart/Get/drawing.dart';
import '../../Tools/MyTheme.dart';
import '../PopUp/Dialog.dart';

final draw = Get.put(drawing());
final uiset = Get.put(uisetting());
final logging = Get.put(logshow());

///LSUI
///
///이 레이아웃은 가로모드일 경우 나타나는 UI이다.
LSUI(context) {
  double height = GetPlatform.isMobile
      ? Get.height - 70 - Get.statusBarHeight
      : Get.height - 110 - Get.statusBarHeight;
  return SingleChildScrollView(
    physics: const ScrollPhysics(),
    child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: GetPlatform.isWeb
            ? Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: (height - 20) * 0.7,
                        width: (Get.width - 60) * 0.6,
                        child: ShowModelGraph(context, (height - 20) * 0.7,
                            (Get.width - 60) * 0.6, 'ls'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: (height - 20) * 0.3,
                        width: (Get.width - 60) * 0.6,
                        child: ModelBtn(context, (height - 20) * 0.3,
                            (Get.width - 40) * 0.6),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: ((height - 20) * 0.5),
                        width: (Get.width - 60) * 0.4,
                        child: SummaryModel(context, (height - 20) * 0.5,
                            (Get.width - 60) * 0.4),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: ((height - 20) * 0.5),
                        width: (Get.width - 60) * 0.4,
                        child: ModelSetting(context, ((height - 20) * 0.5),
                            (Get.width - 60) * 0.4),
                      ),
                    ],
                  )
                ],
              )
            : Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: (height - 20) * 0.8,
                        width: (Get.width - 60) * 0.6,
                        child: ShowModelGraph(context, (height - 20) * 0.8,
                            (Get.width - 60) * 0.6, 'ls'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: (height - 20) * 0.6,
                        width: (Get.width - 60) * 0.6,
                        child: ModelBtn(context, (height - 20) * 0.6,
                            (Get.width - 40) * 0.6),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: ((height - 20) * 0.7),
                        width: (Get.width - 60) * 0.4,
                        child: SummaryModel(context, ((height - 20) * 0.7),
                            (Get.width - 60) * 0.4),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: ((height - 20) * 0.7),
                        width: (Get.width - 60) * 0.4,
                        child: ModelSetting(context, ((height - 20) * 0.7),
                            (Get.width - 60) * 0.4),
                      ),
                    ],
                  )
                ],
              )),
  );
}

///PRUI
///
///이 레이아웃은 세로모드일 경우 나타나는 UI이다.
PRUI(context) {
  double height = GetPlatform.isMobile
      ? Get.height - 70 - Get.statusBarHeight
      : Get.height - 110 - Get.statusBarHeight;
  return SingleChildScrollView(
    physics: const ScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(
            height: (height - 40) * 0.6,
            width: (Get.width - 40),
            child: ShowModelGraph(
                context, (height - 40) * 0.6, (Get.width - 40), 'pr'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: (height - 40) * 0.4,
                width: (Get.width - 60) * 0.5,
                child: SummaryModel(
                    context, (height - 40) * 0.4, (Get.width - 60) * 0.5),
              ),
              const SizedBox(width: 20),
              SizedBox(
                height: (height - 40) * 0.4,
                width: (Get.width - 60) * 0.5,
                child: ModelSetting(
                    context, (height - 40) * 0.4, (Get.width - 60) * 0.5),
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: (height - 40) * 0.4,
            width: (Get.width - 40),
            child: ModelBtn(context, (height - 40) * 0.4, (Get.width - 40)),
          ),
        ],
      ),
    ),
  );
}

ShowModelGraph(context, maxHeight, maxWidth, orientation) {
  return ContainerDesign(
    color: MyTheme.chartcolor,
    child: Column(
      children: [
        Row(
          children: [
            Flexible(
                fit: FlexFit.tight,
                child: Text(
                  '',
                  style: MyTheme.bigcontentText,
                  textAlign: TextAlign.start,
                )),
            GetBuilder<uisetting>(builder: (_) {
              return Container(
                height: 30,
                width: 50,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    StartOrStop();
                  },
                  child: ContainerDesign(
                      color: MyTheme.colorwhite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: MyTheme.redcolortext,
                                shape: BoxShape.circle),
                            width: uiset.startorstop ? 10 : 5,
                            height: uiset.startorstop ? 10 : 5,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: MyTheme.bluecolortext,
                                shape: BoxShape.circle),
                            width: !uiset.startorstop ? 10 : 5,
                            height: !uiset.startorstop ? 10 : 5,
                          )
                        ],
                      )),
                ),
              );
            })
          ],
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Center(
                child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }, scrollbars: false),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                child: Text(
                  '',
                  style: MyTheme.bigcontentText,
                  textAlign: TextAlign.center,
                ),
              ),
            )),
          ),
        )
      ],
    ),
  );
}

ModelBtn(context, maxHeight, maxWidth) {
  return ContainerDesign(
    color: MyTheme.chartcolor,
    child: Column(
      children: [
        Row(
          children: [
            Flexible(
                fit: FlexFit.tight,
                child: Text(
                  '로그기록',
                  style: MyTheme.bigcontentText,
                  textAlign: TextAlign.start,
                )),
            GestureDetector(
              onTap: () {
                ModelBtnDialog();
              },
              child: Icon(
                SimpleLineIcons.question,
                size: 20,
                color: MyTheme.bluecolortext,
              ),
            )
          ],
        ),
        Container(
          height: 2,
          color: Colors.black45,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: PageViewStreamParent1(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              PageViewRes1_1(snapshot);
              return logging.showlist.isEmpty
                  ? Notin(maxHeight, maxWidth)
                  : Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox(
                        height: maxHeight,
                        width: maxWidth,
                        child: ListShowing(maxHeight, maxWidth),
                      ));
            } else if (!snapshot.hasData) {
              return Notin(maxHeight, maxWidth);
            }
            return LinearProgressIndicator(
              backgroundColor: draw.backgroundcolor,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            );
          },
        )
      ],
    ),
  );
}

SummaryModel(context, maxHeight, maxWidth) {
  //maxWidth가 350이하일 때 이 뷰를 쪼개서 화살표로 뷰 넘기는 액션 선택
  return ContainerDesign(
      color: MyTheme.chartcolor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    '요약',
                    style: MyTheme.bigcontentText,
                    textAlign: TextAlign.start,
                  )),
              GestureDetector(
                onTap: () {
                  SummaryModelDialog();
                },
                child: Icon(
                  SimpleLineIcons.question,
                  size: 20,
                  color: MyTheme.bluecolortext,
                ),
              )
            ],
          ),
          GetBuilder<uisetting>(builder: (_) {
            return Flexible(
                fit: FlexFit.tight,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      maxWidth < 300 && uiset.summarylistnumber == 1
                          ? SizedBox(
                              width: 20,
                              child: GestureDetector(
                                onTap: () {
                                  uiset.setSummarylistnumber(0);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: MyTheme.bluecolortext,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.chevron_left,
                                    size: 18,
                                    color: MyTheme.iconcolor,
                                  ),
                                ),
                              ))
                          : Container(
                              width: 20,
                            ),
                      maxWidth < 300
                          ? (uiset.summarylistnumber == 0
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Text(
                                        'Key',
                                        style: MyTheme.insidecontainerText,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    ContainerDesign(
                                        color: MyTheme.greencolortext,
                                        child: SizedBox(
                                          width: maxWidth * 0.3,
                                          child: Text(
                                            uiset.key.toString(),
                                            style: MyTheme.insidesummaryText,
                                            textAlign: TextAlign.center,
                                          ),
                                        ))
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Text(
                                        'Threshold',
                                        style: MyTheme.insidecontainerText,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    ContainerDesign(
                                        color: MyTheme.greencolortext,
                                        child: SizedBox(
                                          width: maxWidth * 0.3,
                                          child: Text(
                                            uiset.threshold.toString(),
                                            style: MyTheme.insidesummaryText,
                                            textAlign: TextAlign.center,
                                          ),
                                        ))
                                  ],
                                ))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Text(
                                        'Key',
                                        style: MyTheme.insidecontainerText,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    ContainerDesign(
                                        color: MyTheme.greencolortext,
                                        child: SizedBox(
                                          width: maxWidth * 0.3,
                                          child: Text(
                                            uiset.key.toString(),
                                            style: MyTheme.insidesummaryText,
                                            textAlign: TextAlign.center,
                                          ),
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Text(
                                        'Threshold',
                                        style: MyTheme.insidecontainerText,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    ContainerDesign(
                                        color: MyTheme.greencolortext,
                                        child: SizedBox(
                                          width: maxWidth * 0.3,
                                          child: Text(
                                            uiset.threshold.toString(),
                                            style: MyTheme.insidesummaryText,
                                            textAlign: TextAlign.center,
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                      maxWidth < 300 && uiset.summarylistnumber == 0
                          ? SizedBox(
                              width: 20,
                              child: GestureDetector(
                                onTap: () {
                                  uiset.setSummarylistnumber(1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: MyTheme.bluecolortext,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.chevron_right,
                                    size: 18,
                                    color: MyTheme.iconcolor,
                                  ),
                                ),
                              ))
                          : Container(
                              width: 20,
                            ),
                    ],
                  ),
                ));
          })
        ],
      ));
}

ModelSetting(context, maxHeight, maxWidth) {
  Timer? timer;
  return StatefulBuilder(builder: ((context, setState) {
    return ContainerDesign(
        color: MyTheme.chartcolor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      '설정',
                      style: MyTheme.bigcontentText,
                      textAlign: TextAlign.start,
                    )),
                GestureDetector(
                  onTap: () {
                    ModelSettingDialog();
                  },
                  child: Icon(
                    SimpleLineIcons.question,
                    size: 20,
                    color: MyTheme.bluecolortext,
                  ),
                ),
                Container(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    //모델에 적용하게 로직 구성
                  },
                  child: Icon(
                    MaterialIcons.published_with_changes,
                    size: 20,
                    color: MyTheme.redcolortext,
                  ),
                )
              ],
            ),
            GetBuilder<uisetting>(builder: (_) {
              return Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                'Key',
                                style: MyTheme.insidecontainerText,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ContainerDesign(
                                color: MyTheme.greencolortext,
                                child: SizedBox(
                                    width: maxWidth * 0.3,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                if (uiset.key == 1) {
                                                  uiset.setKey(1);
                                                } else {
                                                  uiset.key = uiset.key - 1;
                                                  uiset.setKey(uiset.key);
                                                }
                                              },
                                              onLongPress: () {
                                                timer = Timer.periodic(
                                                    const Duration(
                                                        milliseconds: 50),
                                                    (timer) {
                                                  setState(() {
                                                    if (uiset.key == 1) {
                                                      uiset.setKey(1);
                                                    } else {
                                                      uiset.key = uiset.key - 1;
                                                      uiset.setKey(uiset.key);
                                                    }
                                                  });
                                                });
                                              },
                                              onLongPressEnd: (_) {
                                                timer?.cancel();
                                              },
                                              child: Text(
                                                '-',
                                                style:
                                                    MyTheme.insidesummaryText,
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            uiset.key.toString(),
                                            style: MyTheme.insidesummaryText,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Flexible(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                if (uiset.key == 6) {
                                                  uiset.setKey(6);
                                                } else {
                                                  uiset.key = uiset.key + 1;
                                                  uiset.setKey(uiset.key);
                                                }
                                              },
                                              onLongPress: () {
                                                timer = Timer.periodic(
                                                    const Duration(
                                                        milliseconds: 50),
                                                    (timer) {
                                                  setState(() {
                                                    if (uiset.key == 6) {
                                                      uiset.setKey(6);
                                                    } else {
                                                      uiset.key = uiset.key + 1;
                                                      uiset.setKey(uiset.key);
                                                    }
                                                  });
                                                });
                                              },
                                              onLongPressEnd: (_) {
                                                timer?.cancel();
                                              },
                                              child: Text(
                                                '+',
                                                style:
                                                    MyTheme.insidesummaryText,
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                      ],
                                    )))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                'Threshold',
                                style: MyTheme.insidecontainerText,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ContainerDesign(
                                color: MyTheme.greencolortext,
                                child: SizedBox(
                                    width: maxWidth * 0.3,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                if (uiset.threshold == 1) {
                                                  uiset.setThreshold(1);
                                                } else {
                                                  uiset.threshold =
                                                      uiset.threshold - 1;
                                                  uiset.setThreshold(
                                                      uiset.threshold);
                                                }
                                              },
                                              onLongPress: () {
                                                timer = Timer.periodic(
                                                    const Duration(
                                                        milliseconds: 50),
                                                    (timer) {
                                                  setState(() {
                                                    if (uiset.threshold == 1) {
                                                      uiset.setThreshold(1);
                                                    } else {
                                                      uiset.threshold =
                                                          uiset.threshold - 1;
                                                      uiset.setThreshold(
                                                          uiset.threshold);
                                                    }
                                                  });
                                                });
                                              },
                                              onLongPressEnd: (_) {
                                                timer?.cancel();
                                              },
                                              child: Text(
                                                '-',
                                                style:
                                                    MyTheme.insidesummaryText,
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            uiset.threshold.toString(),
                                            style: MyTheme.insidesummaryText,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Flexible(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                if (uiset.threshold == 100) {
                                                  uiset.setThreshold(100);
                                                } else {
                                                  uiset.threshold =
                                                      uiset.threshold + 1;
                                                  uiset.setThreshold(
                                                      uiset.threshold);
                                                }
                                              },
                                              onLongPress: () {
                                                timer = Timer.periodic(
                                                    const Duration(
                                                        milliseconds: 50),
                                                    (timer) {
                                                  setState(() {
                                                    if (uiset.threshold ==
                                                        100) {
                                                      uiset.setThreshold(100);
                                                    } else {
                                                      uiset.threshold =
                                                          uiset.threshold + 1;
                                                      uiset.setThreshold(
                                                          uiset.threshold);
                                                    }
                                                  });
                                                });
                                              },
                                              onLongPressEnd: (_) {
                                                timer?.cancel();
                                              },
                                              child: Text(
                                                '+',
                                                style:
                                                    MyTheme.insidesummaryText,
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                      ],
                                    )))
                          ],
                        ),
                      ],
                    ),
                  ));
            })
          ],
        ));
  }));
}

ListShowing(maxHeight, maxWidth) {
  return ListView.builder(
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: false,
      itemCount: logging.showlist.length,
      itemBuilder: ((context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      logging.showlist[index].title,
                      style: logging.showlist[index].title == 'Stop'
                          ? MyTheme.WarningText
                          : MyTheme.bigcontentText,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  logging.showlist[index].date,
                  style: MyTheme.smallcontentText,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      }));
}

Notin(maxHeight, maxWidth) {
  return Flexible(
      fit: FlexFit.tight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            AntDesign.frowno,
            color: Colors.orange,
            size: 30,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            '로그가 비어있습니다.',
            textAlign: TextAlign.center,
            style: MyTheme.insidecontainerText,
          ),
        ],
      ));
}
