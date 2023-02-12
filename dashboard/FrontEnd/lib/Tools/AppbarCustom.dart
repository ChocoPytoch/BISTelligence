// ignore_for_file: unused_local_variable, must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:app/BackPart/Get/drawing.dart';
import 'package:app/Tools/ContainerDesign.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../BackPart/Get/uisetting.dart';
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
