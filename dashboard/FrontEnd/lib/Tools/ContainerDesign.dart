import 'package:app/BackPart/Get/drawing.dart';
import 'package:app/Tools/MyTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContainerDesign extends StatelessWidget {
  const ContainerDesign({Key? key, required this.child, required this.color})
      : super(key: key);
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<drawing>(
        builder: (_) => Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: child,
            ));
  }
}

class ContainerTextFieldDesign extends StatelessWidget {
  const ContainerTextFieldDesign(
      {Key? key,
      required this.searchNodeAddSection,
      required this.string,
      required this.textEditingControllerAddSheet,
      required this.color})
      : super(key: key);
  final FocusNode searchNodeAddSection;
  final String string;
  final TextEditingController textEditingControllerAddSheet;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        focusNode: searchNodeAddSection,
        style: MyTheme.smallcontentText,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        readOnly: true,
        decoration: InputDecoration(
            border: InputBorder.none,
            isCollapsed: true,
            hintMaxLines: 4,
            hintText: string,
            hintStyle: MyTheme.smallcontentText),
        controller: textEditingControllerAddSheet,
      ),
    );
  }
}
