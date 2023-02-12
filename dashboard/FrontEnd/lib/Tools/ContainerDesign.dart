import 'package:app/BackPart/Get/drawing.dart';
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
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: child,
            ));
  }
}
