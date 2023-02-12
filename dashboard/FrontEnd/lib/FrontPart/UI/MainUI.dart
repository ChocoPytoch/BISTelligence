// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:async';
import 'dart:ui';
import 'package:app/BackPart/Get/logshow.dart';
import 'package:app/BackPart/Get/uisetting.dart';
import 'package:app/Tools/ContainerDesign.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import '../../BackPart/Enum/keyitems.dart';
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
LSUI(context, int key) {
  double height = GetPlatform.isMobile
      ? Get.height - 70 - Get.statusBarHeight
      : Get.height - 110 - Get.statusBarHeight;
  return SingleChildScrollView(
    physics: const ScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Get.width > 700 && GetPlatform.isWeb
          ? Row(
              children: [
                SizedBox(
                  height: (height - 20),
                  width: (Get.width - 60) * 0.6,
                  child: ShowModelGraph(context, (height - 20),
                      (Get.width - 60) * 0.6, 'ls', key),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  height: (height - 20),
                  width: (Get.width - 60) * 0.4,
                  child:
                      ModelLog(context, (height - 20), (Get.width - 60) * 0.4),
                ),
              ],
            )
          : Column(
              children: [
                SizedBox(
                  height: (height - 20) * 1.5,
                  width: (Get.width - 40),
                  child: ShowModelGraph(context, (height - 20) * 1.5,
                      (Get.width - 40), 'ls', key),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: (height - 20) * 0.8,
                  width: (Get.width - 40),
                  child:
                      ModelLog(context, (height - 20) * 0.8, (Get.width - 40)),
                ),
              ],
            ),
    ),
  );
}

///PRUI
///
///이 레이아웃은 세로모드일 경우 나타나는 UI이다.
PRUI(context, int key) {
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
            height: (height - 20) * 0.8,
            width: (Get.width - 40),
            child: ShowModelGraph(
                context, (height - 20) * 0.8, (Get.width - 40), 'ls', key),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: (height - 20) * 0.6,
            width: (Get.width - 40),
            child: ModelLog(context, (height - 20) * 0.6, (Get.width - 40)),
          ),
        ],
      ),
    ),
  );
}

ShowModelGraph(context, maxHeight, maxWidth, orientation, int key) {
  String? selectedValue;

  return ContainerDesign(
    color: MyTheme.chartcolor,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StatefulBuilder(builder: ((context, setState) {
              return SizedBox(
                height: 30,
                width: 150,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text('Key ${uiset.key}',
                          style: MyTheme.smallcontentText),
                    ),
                    items: addDividersAfterItems(),
                    customItemsHeights: getCustomItemsHeights(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                        uiset.setKey(int.parse(value.toString().substring(3)));
                      });
                    },
                    buttonHeight: 30,
                    buttonDecoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black45,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    buttonPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                    dropdownMaxHeight: 150,
                    buttonWidth: 150,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                ),
              );
            })),
            GetBuilder<uisetting>(builder: (_) {
              return Container(
                height: 30,
                width: 50,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    StartOrStop();
                  },
                  child: Container(
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: MyTheme.colorwhite,
                        borderRadius: BorderRadius.circular(15),
                      ),
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
        const SizedBox(
          height: 10,
        ),
        GetBuilder<uisetting>(builder: (_) {
          return Row(
            children: [
              SizedBox(
                  height: uiset.key != key ? maxHeight - 140 : maxHeight - 70,
                  width: 40,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: thresholditems.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            index == 0
                                ? const SizedBox()
                                : SizedBox(
                                    height: uiset.key != key
                                        ? (maxHeight - 140 - 20 * 11) * 0.05
                                        : (maxHeight - 70 - 20 * 11) * 0.05,
                                  ),
                            SizedBox(
                              height: 20,
                              child: Text(
                                thresholditems[index].toString(),
                                style: MyTheme.insidecontainerText,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            index == thresholditems.length - 1
                                ? const SizedBox()
                                : SizedBox(
                                    height: uiset.key != key
                                        ? (maxHeight - 140 - 20 * 11) * 0.05
                                        : (maxHeight - 70 - 20 * 11) * 0.05,
                                  ),
                          ],
                        );
                      },
                    ),
                  )),
              GetBuilder<uisetting>(builder: (_) {
                return Container(
                  height: uiset.key != key ? maxHeight - 140 : maxHeight - 70,
                  width: maxWidth - 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black45,
                    ),
                  ),
                );
              })
            ],
          );
        }),
        const SizedBox(
          height: 10,
        ),
        GetBuilder<uisetting>(builder: (_) {
          return uiset.key != key
              ? ContainerDesign(
                  color: draw.backgroundcolor,
                  child: SizedBox(
                      height: 50,
                      width: maxWidth - 20,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                              fit: FlexFit.tight,
                              child: Text(
                                '변동사항이 있습니다. 모델에 적용하시겠습니까?',
                                style: MyTheme.insidecontainerText,
                                textAlign: TextAlign.start,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              //key값을 tmpkey에 변경값을 적용
                              uiset.settmpKey(uiset.key);
                            },
                            child: Icon(
                              MaterialIcons.published_with_changes,
                              size: 20,
                              color: MyTheme.redcolortext,
                            ),
                          )
                        ],
                      )))
              : const SizedBox();
        }),
      ],
    ),
  );
}

ModelLog(context, maxHeight, maxWidth) {
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
                ModelLogDialog();
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
