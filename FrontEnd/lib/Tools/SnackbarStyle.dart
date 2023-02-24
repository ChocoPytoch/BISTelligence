// ignore_for_file: file_names

import 'package:app/Tools/MyTheme.dart';
import 'package:flutter/material.dart';

class Snack {
  static snackbars({
    required BuildContext context,
    required String title,
    required Color backgroundcolor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        title,
        maxLines: 3,
        style: MyTheme.insidesummaryText,
      ),
      duration: const Duration(milliseconds: 1000),
      behavior: SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: const BorderSide(
          color: Colors.white,
          width: 2,
        ),
      ),
      backgroundColor: backgroundcolor,
    ));
  }
}
