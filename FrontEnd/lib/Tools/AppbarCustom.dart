// ignore_for_file: unused_local_variable, must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:app/BackPart/Get/drawing.dart';
import 'package:app/Tools/ContainerDesign.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import '../BackPart/Firebase/Streams.dart';
import '../BackPart/Get/uisetting.dart';
import '../FrontPart/PopUp/Dialog.dart';
import 'MyTheme.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({
    Key? key,
    required this.title,
    required this.lefticon,
    required this.lefticonname,
    required this.righticon,
    required this.righticonname,
  }) : super(key: key);
  final String title;
  final bool lefticon;
  final IconData lefticonname;
  final bool righticon;
  final IconData righticonname;

  @override
  Widget build(BuildContext context) {
    ///변수 선언구간
    final uiset = Get.put(uisetting());
    final draw = Get.put(drawing());

    return StatefulBuilder(builder: ((context, setState) {
      return GetBuilder<drawing>(
          builder: (_) => SafeArea(
              child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        lefticon == true
                            ? Row(
                                children: [
                                  GetBuilder<uisetting>(
                                      builder: (_) => ContainerDesign(
                                            color: MyTheme.chartcolor,
                                            child: GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.zero,
                                                  child: Icon(
                                                    lefticonname,
                                                    size: 25,
                                                    color:
                                                        MyTheme.bluecolortext,
                                                  ),
                                                )),
                                          ))
                                ],
                              )
                            : const SizedBox(),
                        Flexible(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                fit: FlexFit.tight,
                                child: SizedBox(
                                  child: Text(
                                    title.toString(),
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: MyTheme.appbarTitle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                            righticon == true
                                ? Row(
                                    children: [
                                      ContainerDesign(
                                        color: MyTheme.chartcolor,
                                        child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.zero,
                                              child: Icon(
                                                righticonname,
                                                size: 25,
                                                color: MyTheme.bluecolortext,
                                              ),
                                            )),
                                      )
                                    ],
                                  )
                                : const SizedBox()
                            /*StreamBuilder<QuerySnapshot>(
                                    stream: PageViewStreamParent1(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        PageViewRes1_1(snapshot);
                                      }
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
                                                  left: 5,
                                                  right: 5,
                                                  top: 5,
                                                  bottom: 5),
                                              decoration: BoxDecoration(
                                                color: MyTheme.iconcolor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: MyTheme
                                                            .redcolortext,
                                                        shape: BoxShape.circle),
                                                    width: !logging.startorstop
                                                        ? 10
                                                        : 5,
                                                    height: !logging.startorstop
                                                        ? 10
                                                        : 5,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: MyTheme
                                                            .bluecolortext,
                                                        shape: BoxShape.circle),
                                                    width: logging.startorstop
                                                        ? 10
                                                        : 5,
                                                    height: logging.startorstop
                                                        ? 10
                                                        : 5,
                                                  )
                                                ],
                                              )),
                                        ),
                                      );
                                    },
                                  )*/
                          ],
                        )),
                      ],
                    ),
                  ))));
    }));
  }

  OnClickedRightIcons(context, righticonname) {
    ///우측 아이콘 클릭시 호출
  }
}
