// ignore_for_file: non_constant_identifier_names, file_names, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:app/BackPart/Get/logshow.dart';
import 'package:app/BackPart/Get/uisetting.dart';
import 'package:app/Tools/ContainerDesign.dart';
import 'package:app/Tools/SnackbarStyle.dart';
import 'package:app/Tools/Variables.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../BackPart/Enum/keyitems.dart';
import '../../BackPart/Enum/modelinsights.dart';
//import '../../BackPart/Firebase/Streams.dart';
import '../../BackPart/Get/drawing.dart';
import '../../Tools/MyTheme.dart';
import '../PopUp/Dialog.dart';

final draw = Get.put(drawing());
final uiset = Get.put(uisetting());
final logging = Get.put(logshow());
final GlobalKey btnkey = GlobalKey();

///LSUI
///
///이 레이아웃은 가로모드일 경우 나타나는 UI이다.
LSUI(
  context,
  int key,
  ScrollController mainscroller,
  ScrollController logscroller,
  TextEditingController txtcontroller,
  FocusNode focusnode,
) {
  double height = GetPlatform.isMobile
      ? Get.height - 70 - Get.statusBarHeight
      : Get.height - 70;
  double ratio = height / Get.width;
  return SingleChildScrollView(
    physics: const ScrollPhysics(),
    controller: mainscroller,
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: (GetPlatform.isWeb && Get.width > 500) || (ratio < 1.2)
          ? Row(
              children: [
                SizedBox(
                  height: height < 500 ? (height - 20) * 1.5 : (height - 20),
                  width: (Get.width - 60) * 0.6,
                  child: ShowModelGraph(
                    context,
                    height < 500 ? (height - 20) * 1.5 : (height - 20),
                    (Get.width - 60) * 0.6,
                    'ls',
                    key,
                    txtcontroller,
                    focusnode,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  height: height < 500 ? (height - 20) * 1.5 : (height - 20),
                  width: (Get.width - 60) * 0.4,
                  child: Column(
                    children: [
                      SizedBox(
                          height: height < 500
                              ? (height - 20) * 1.5
                              : (height - 20),
                          width: (Get.width - 60) * 0.4,
                          child: SummaryModel(
                              context,
                              height < 500
                                  ? (height - 20) * 1.5
                                  : (height - 20),
                              (Get.width - 60) * 0.4,
                              key)),
                      /*const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: height < 500
                            ? ((height - 20) * 1.5 - 20) * 0.4
                            : ((height - 20) - 20) * 0.4,
                        width: (Get.width - 60) * 0.4,
                        child: ModelLog(
                            context,
                            height < 500
                                ? ((height - 20) * 1.5 - 20) * 0.4
                                : ((height - 20) - 20) * 0.4,
                            (Get.width - 60) * 0.4,
                            logscroller),
                      ),*/
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                SizedBox(
                  height: (height - 20) * 1.5,
                  width: (Get.width - 40),
                  child: ShowModelGraph(
                    context,
                    (height - 20) * 1.5,
                    (Get.width - 40),
                    'ls',
                    key,
                    txtcontroller,
                    focusnode,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: (height - 20),
                    width: (Get.width - 40),
                    child: SummaryModel(
                        context, (height - 20), (Get.width - 40), key)),
                const SizedBox(
                  height: 50,
                ),
                /*SizedBox(
                    height: (height - 60) * 0.5,
                    width: (Get.width - 40),
                    child: ModelLog(context, (height - 60) * 0.5,
                        (Get.width - 40), logscroller),
                  ),*/
              ],
            ),
    ),
  );
}

///PRUI
///
///이 레이아웃은 세로모드일 경우 나타나는 UI이다.
PRUI(
  context,
  int key,
  ScrollController mainscroller,
  ScrollController logscroller,
  TextEditingController txtcontroller,
  FocusNode focusnode,
) {
  double height = GetPlatform.isMobile
      ? Get.height - 70 - Get.statusBarHeight
      : Get.height - 70;
  return SingleChildScrollView(
    physics: const ScrollPhysics(),
    controller: mainscroller,
    child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Get.height > 500
            ? Column(
                children: [
                  SizedBox(
                    height: (height - 90) * 1,
                    width: (Get.width - 40),
                    child: ShowModelGraph(
                      context,
                      (height - 90) * 1,
                      (Get.width - 40),
                      'ls',
                      key,
                      txtcontroller,
                      focusnode,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: (height - 90) * 0.8,
                      width: (Get.width - 40),
                      child: SummaryModel(
                          context, (height - 90) * 0.8, (Get.width - 40), key)),
                  const SizedBox(
                    height: 50,
                  ),
                  /*SizedBox(
                    height: (height - 60) * 0.4,
                    width: (Get.width - 40),
                    child: ModelLog(context, (height - 60) * 0.4,
                        (Get.width - 40), logscroller),
                  ),*/
                ],
              )
            : Column(
                children: [
                  SizedBox(
                    height: (height - 20) * 1.5,
                    width: (Get.width - 40),
                    child: ShowModelGraph(
                      context,
                      (height - 20) * 1.5,
                      (Get.width - 40),
                      'ls',
                      key,
                      txtcontroller,
                      focusnode,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: (height - 20),
                      width: (Get.width - 40),
                      child: SummaryModel(
                          context, (height - 20), (Get.width - 40), key)),
                  const SizedBox(
                    height: 50,
                  ),
                  /*SizedBox(
                    height: (height - 60) * 0.5,
                    width: (Get.width - 40),
                    child: ModelLog(context, (height - 60) * 0.5,
                        (Get.width - 40), logscroller),
                  ),*/
                ],
              )),
  );
}

///showPopupMenu
///
///메인보드에서 원인분석 버튼을 누를 경우 나타나는 UI이다.
showPopupMenu(context, offset) async {
  await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
        offset.dx, offset.dy, offset.dx + 1, offset.dy + 1),
    items: [
      PopupMenuItem(
        value: 0,
        onTap: () async {
          uiset.setdbimgshow('sp');
          uiset.BackgroundloadImage();
          //connection.fetchImage();
        },
        child: Row(
          children: [
            Icon(
              MaterialCommunityIcons.chart_gantt,
              size: 15,
              color: MyTheme.bluecolortext,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
                fit: FlexFit.tight,
                child: Text(
                  'Summary Plot보기',
                  style: MyTheme.insidecontainerText,
                  textAlign: TextAlign.start,
                )),
          ],
        ),
      ),
      PopupMenuItem(
        value: 1,
        onTap: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            PlotDialog();
          });
        },
        child: Row(
          children: [
            Icon(
              MaterialCommunityIcons.plus_minus_variant,
              size: 15,
              color: MyTheme.bluecolortext,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
                fit: FlexFit.tight,
                child: Text(
                  'Force Plot보기',
                  style: MyTheme.insidecontainerText,
                  textAlign: TextAlign.start,
                )),
          ],
        ),
      ),
    ],
    elevation: 8.0,
  );
}

///ShowModelGraph
///
///메인보드 UI이다.
ShowModelGraph(
  context,
  maxHeight,
  maxWidth,
  orientation,
  int key,
  TextEditingController txtcontroller,
  FocusNode focusnode,
) {
  String? selectedValue;
  ChartSeriesController? chartSeriesController;
  var tooltipsinlist = TooltipBehavior(
      enable: uiset.imgshow == 'fp' || uiset.imgshow == 'pause' ? true : false);

  return StatefulBuilder(builder: ((context, setState) {
    return ContainerDesign(
      color: MyTheme.chartcolor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                width: 80,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Padding(
                      padding: EdgeInsets.zero,
                      child: Text(
                        'Key ${uiset.key}',
                        style: MyTheme.smallcontentText,
                        overflow: TextOverflow.fade,
                      ),
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
                      borderRadius: BorderRadius.circular(5),
                    ),
                    buttonPadding: EdgeInsets.zero,
                    dropdownMaxHeight: 150,
                    buttonWidth: 80,
                    itemPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Row(
                children: [
                  GetBuilder<uisetting>(builder: (_) {
                    return GestureDetector(
                        onTapDown: (details) {
                          //uiset.key가 key와 동일한 경우에만 터치이벤트 실행
                          if (uiset.key == key) {
                            if (uiset.imgshow != '') {
                              Snack.snackbars(
                                  context: context,
                                  title: '키값을 변경하는 도중에 분석은 불가합니다!',
                                  backgroundcolor: MyTheme.redcolortext);
                            } else {
                              uiset.imgurl = '';
                              showPopupMenu(context, details.globalPosition);
                            }
                          } else {
                            Snack.snackbars(
                                context: context,
                                title: '키값을 변경하는 도중에 분석은 불가합니다!',
                                backgroundcolor: MyTheme.redcolortext);
                          }
                        },
                        child: uiset.key == key
                            ? (uiset.imgshow != ''
                                ? Icon(
                                    MaterialIcons.do_not_disturb,
                                    size: 20,
                                    color: MyTheme.redcolortext,
                                  )
                                : Icon(
                                    SimpleLineIcons.chart,
                                    size: 20,
                                    color: MyTheme.bluecolortext,
                                  ))
                            : Icon(
                                MaterialIcons.do_not_disturb,
                                size: 20,
                                color: MyTheme.redcolortext,
                              ));
                  }),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Column(
                children: [
                  GetBuilder<uisetting>(builder: (_) {
                    return SizedBox(
                        height:
                            uiset.key != key ? maxHeight - 140 : maxHeight - 80,
                        width: 40,
                        child: SfSlider.vertical(
                          min: 0.0,
                          max: uiset.maxy == 0.0 ? 5 : uiset.maxy,
                          showLabels: true,
                          onChanged: (value) {
                            uiset.setdefaulty(value);
                          },
                          onChangeEnd: (value) {
                            uiset.setdefaulty(value);
                          },
                          value: uiset.defaulty,
                          interval: uiset.maxy == 0.0 ? 1 : uiset.maxy / 3,
                          showTicks: true,
                          showDividers: true,
                          enableTooltip: true,
                          minorTicksPerInterval: 5,
                          tooltipPosition: SliderTooltipPosition.right,
                        ));
                  })
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              GetBuilder<uisetting>(
                  initState: (state) =>
                      refreshchartstream(chartSeriesController),
                  builder: (_) {
                    return Container(
                        height:
                            uiset.key != key ? maxHeight - 140 : maxHeight - 80,
                        width: maxWidth - 70,
                        alignment: Alignment.center,
                        child: uiset.key != key
                            ? Stack(
                                children: [
                                  SfCartesianChart(
                                    tooltipBehavior: tooltipsinlist,
                                    primaryXAxis: NumericAxis(
                                        isVisible: true,
                                        autoScrollingMode:
                                            AutoScrollingMode.end),
                                    series: <ChartSeries>[
                                      ScatterSeries(
                                          name: 'key${uiset.key}',
                                          dataSource: uiset.modelinsightslist,
                                          markerSettings: const MarkerSettings(
                                              isVisible: true,
                                              height: 5,
                                              width: 5,
                                              shape: DataMarkerType.circle),
                                          pointColorMapper: (data, index) {
                                            return uiset
                                                        .modelinsightslist[
                                                            index]
                                                        .y >
                                                    uiset.defaulty
                                                ? Colors.red
                                                : Colors.blue;
                                          },
                                          onRendererCreated: (controller) {
                                            chartSeriesController = controller;
                                          },
                                          xValueMapper: ((data, index) {
                                            return uiset
                                                .modelinsightslist[index].x;
                                          }),
                                          yValueMapper: ((datum, index) {
                                            return uiset
                                                .modelinsightslist[index].y;
                                          })),
                                    ],
                                  ),
                                  SizedBox(
                                    child: Center(
                                      child: Text('일시중지',
                                          textAlign: TextAlign.center,
                                          style: MyTheme.WarningsmallText),
                                    ),
                                  )
                                ],
                              )
                            : SfCartesianChart(
                                tooltipBehavior: tooltipsinlist,
                                primaryXAxis: NumericAxis(
                                    isVisible: true,
                                    autoScrollingMode: AutoScrollingMode.end),
                                series: <ChartSeries>[
                                  ScatterSeries(
                                      name: 'key${uiset.key}',
                                      dataSource: uiset.modelinsightslist,
                                      markerSettings: const MarkerSettings(
                                          isVisible: true,
                                          height: 5,
                                          width: 5,
                                          shape: DataMarkerType.circle),
                                      pointColorMapper: (data, index) {
                                        return uiset.modelinsightslist[index]
                                                    .y >
                                                uiset.defaulty
                                            ? Colors.red
                                            : Colors.blue;
                                      },
                                      onRendererCreated: (controller) {
                                        chartSeriesController = controller;
                                      },
                                      onPointTap:
                                          (pointInteractionDetails) async {
                                        uiset.insightstap.clear();
                                        if (uiset.imgshow == '' ||
                                            uiset.imgshow == 'sp') {
                                        } else {
                                          uiset.setdbimgshow('fp');
                                          uiset.imgurl = '';
                                          uiset.insightstap.add(modelinsights(
                                              x: uiset
                                                  .modelinsightslist[
                                                      pointInteractionDetails
                                                          .pointIndex!]
                                                  .x,
                                              y: uiset
                                                  .modelinsightslist[
                                                      pointInteractionDetails
                                                          .pointIndex!]
                                                  .y));
                                          uiset.BackgroundloadImage();
                                        }
                                      },
                                      xValueMapper: ((data, index) {
                                        return uiset.modelinsightslist[index].x;
                                      }),
                                      yValueMapper: ((datum, index) {
                                        return uiset.modelinsightslist[index].y;
                                      })),
                                ],
                              ));
                  })
            ],
          ),
          GetBuilder<uisetting>(builder: (_) {
            return uiset.key != key
                ? Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ContainerDesign(
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
                                        '변동사항이 있습니다. 바로 적용하시겠습니까?',
                                        style: MyTheme.insidecontainerText,
                                        textAlign: TextAlign.start,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (Hive.box('user_setting')
                                              .get('isclickkeychange') ==
                                          true) {
                                        uiset.score_list.clear();
                                        uiset.settmpKey(uiset.key);
                                        uiset.setdefaulty(0.0);
                                        uiset.resetinsights();
                                        uiset.resetlistx();
                                        uiset.fetchlist();
                                        refreshchartstream(
                                            chartSeriesController);
                                      } else {}
                                      Hive.box('user_setting')
                                          .put('isfinished', false);
                                    },
                                    child: Icon(
                                      MaterialIcons.published_with_changes,
                                      size: 20,
                                      color: MyTheme.redcolortext,
                                    ),
                                  )
                                ],
                              )))
                    ],
                  )
                : const SizedBox();
          }),
        ],
      ),
    );
  }));
}

///SummaryModel
///
///분석대시보드 UI이다.
///백엔드에서 이미지를 불러올 때 이곳의 코드 중
///Imgin으로 이동하여 Text 부분을 Image로 교체하면 된다.
///uiset.imgshow 변수는 선택값이 summary인지 force인지에 따라 결정되게 하였음.
///summary => sp, force => fp, default => 공백('')
SummaryModel(context, maxHeight, maxWidth, int key) {
  return ContainerDesign(
      color: MyTheme.chartcolor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    '분석',
                    style: MyTheme.bigcontentText,
                    textAlign: TextAlign.start,
                  )),
              GestureDetector(
                onTap: () {
                  if (uiset.imgurl == '') {
                  } else {
                    uiset.setBigimg(true);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ImgDialog();
                    });
                  }
                },
                child: Icon(
                  AntDesign.arrowsalt,
                  size: 20,
                  color: MyTheme.bluecolortext,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  uiset.imgurl = '';
                  uiset.setdbimgshow('');
                  uiset.insightstap.clear();
                  uiset.status = '';
                },
                child: Icon(
                  Ionicons.refresh,
                  size: 20,
                  color: MyTheme.bluecolortext,
                ),
              )
            ],
          ),
          GetBuilder<uisetting>(builder: (_) {
            return (uiset.imgshow == 'sp' || uiset.imgshow == 'fp')
                ? Imgin(maxHeight, maxWidth)
                : Notin(maxHeight, maxWidth, 'analytic');
          })
        ],
      ));
}

///ModelLog
///
///로그대시보드 UI이다.
///
/*ModelLog(context, maxHeight, maxWidth, ScrollController logscroller) {
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
          height: 10,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: PageViewStreamParent1(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              PageViewRes1_1(snapshot);
              return logging.showlist.isEmpty
                  ? Notin(maxHeight, maxWidth, 'log')
                  : Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox(
                          height: maxHeight,
                          width: maxWidth,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                                scrollbarTheme: ScrollbarThemeData(
                                    thumbColor: MaterialStateProperty.all(
                                        Colors.grey))),
                            child: Scrollbar(
                              controller: logscroller,
                              thumbVisibility: true,
                              thickness: 3,
                              child:
                                  ListShowing(maxHeight, maxWidth, logscroller),
                            ),
                          )));
            } else if (!snapshot.hasData) {
              return Notin(maxHeight, maxWidth, 'log');
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

ListShowing(maxHeight, maxWidth, ScrollController logscroller) {
  return ListView.builder(
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: false,
      controller: logscroller,
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
                Icon(
                  logging.showlist[index].title == 'Stop'
                      ? Entypo.controller_stop
                      : Entypo.controller_play,
                  size: 20,
                  color: logging.showlist[index].title == 'Stop'
                      ? MyTheme.redcolortext
                      : MyTheme.bluecolortext,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    logging.showlist[index].date,
                    textAlign: TextAlign.end,
                    style: MyTheme.smallcontentText,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      }));
}*/

Imgin(maxHeight, maxWidth) {
  return Flexible(
      fit: FlexFit.tight,
      child: Container(
        width: maxWidth,
        height: maxHeight,
        alignment: Alignment.center,
        child: GetBuilder<uisetting>(builder: (_) {
          return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: StreamBuilder(
                stream: uiset.FetchImage(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isNotEmpty) {
                      if (uiset.imgshow == 'sp') {
                        uiset.imgurl = '';
                        uiset.imgurl = snapshot.data[0]['summary_plot'];
                      } else if (uiset.imgshow == 'fp') {
                        uiset.imgurl = '';
                        uiset.imgurl = snapshot.data[0]['force_plot'];
                      } else {
                        uiset.imgurl = '';
                      }
                      return SizedBox(
                        height: maxHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              uiset.imgurl,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      );
                    } else {
                      if (uiset.status == 'Bad Request') {
                        return SizedBox(
                          width: maxWidth * 0.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                AntDesign.frowno,
                                color: Colors.red,
                                size: 30,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                uiset.status,
                                textAlign: TextAlign.center,
                                style: MyTheme.insidecontainerText,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                '리셋 버튼을 클릭하여 재시도',
                                textAlign: TextAlign.center,
                                style: MyTheme.insidecontainerText,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: maxWidth * 0.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: MyTheme.bluecolortext,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                '서버로부터 불러오는 중입니다. 잠시만 기다려주십시오.',
                                textAlign: TextAlign.center,
                                style: MyTheme.insidecontainerText,
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  } else {
                    if (uiset.status == 'Bad Request') {
                      return SizedBox(
                        width: maxWidth * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              AntDesign.frowno,
                              color: Colors.red,
                              size: 30,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              uiset.status,
                              textAlign: TextAlign.center,
                              style: MyTheme.insidecontainerText,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '리셋 버튼을 클릭하여 재시도',
                              textAlign: TextAlign.center,
                              style: MyTheme.insidecontainerText,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: maxWidth * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: MyTheme.bluecolortext,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '서버로부터 불러오는 중입니다. 잠시만 기다려주십시오.',
                              textAlign: TextAlign.center,
                              style: MyTheme.insidecontainerText,
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
              ));
        }),
      ));
}

Notin(maxHeight, maxWidth, string) {
  return Flexible(
      fit: FlexFit.tight,
      child: Container(
        height: maxHeight,
        width: maxWidth * 0.6,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
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
                string == 'log' ? '로그가 비어있습니다.' : '메인보드 우측 상단 아이콘을 선택',
                textAlign: TextAlign.center,
                style: MyTheme.insidecontainerText,
              ),
            ],
          ),
        ),
      ));
}

refreshchartstream(chartSeriesController) async {
  List<modelinsights> modellisttmp = [];
  await uiset.fetchlist();
  if (uiset.key != uiset.tmpkey ||
      Hive.box('user_setting').get('isfinished') == true ||
      !logging.startorstop) {
  } else {
    for (int i = 0; i < uiset.score_list.length; i++) {
      if (uiset.listx == keynum[uiset.key - 1] - 1) {
        Hive.box('user_setting').put('isfinished', true);
      } else {
        /*modellist.add(modelinsights(
              x: i, y: jsonResponse[i]['Score']));*/
        uiset.modelinsightslist
            .add(modelinsights(x: i, y: uiset.score_list[i]));
        calculatey();
        modelchartlive(chartSeriesController, uiset.modelinsightslist);
        uiset.listx += 1;
        //modellist.clear();
      }
    }
    /*Future.delayed(const Duration(seconds: 1), () {
      if (uiset.listx == keynum[uiset.key - 1] - 1) {
        Hive.box('user_setting').put('isfinished', true);
        uiset.listx = 0;
      } else {
        uiset.modelinsightslist.add(
            modelinsights(x: uiset.listx, y: uiset.score_list[uiset.listx]));
        modellisttmp.add(uiset.modelinsightslist[0]);
        calculatey();
        modelchartlive(chartSeriesController, modellisttmp);
        modellisttmp.clear();
        uiset.listx = uiset.listx + 1;
      }
    });*/
  }
}

calculatey() {
  if (uiset.listx == 0) {
    uiset.setmaxy(uiset.modelinsightslist[uiset.listx].y);
  } else {
    if (uiset.modelinsightslist[uiset.listx].y >
        uiset.modelinsightslist[uiset.listx - 1].y) {
      uiset.setmaxy(uiset.modelinsightslist[uiset.listx].y);
    }
  }
}

modelchartlive(chartSeriesController, List<modelinsights> modelinsightslist) {
  chartSeriesController?.updateDataSource(
    addedDataIndexes: <int>[modelinsightslist.length - 1],
  );
}
