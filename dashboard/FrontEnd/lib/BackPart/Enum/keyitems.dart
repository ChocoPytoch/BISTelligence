import 'package:app/Tools/MyTheme.dart';
import 'package:flutter/material.dart';

final List<String> keyitems = [
  'Key1',
  'Key2',
  'Key3',
  'Key4',
  'Key5',
  'Key6',
];
final List<String> thresholditems = [
  '11',
  '10',
  '9',
  '8',
  '7',
  '6',
  '5',
  '4',
  '3',
  '2',
  '1',
];
List<DropdownMenuItem<String>> addDividersAfterItems() {
  List<DropdownMenuItem<String>> _menuItems = [];
  for (var item in keyitems) {
    _menuItems.addAll(
      [
        DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(item, style: MyTheme.smallcontentText),
          ),
        ),
        //If it's last item, we will not add Divider after it.
        if (item != keyitems.last)
          const DropdownMenuItem<String>(
            enabled: false,
            child: Divider(),
          ),
      ],
    );
  }
  return _menuItems;
}

List<double> getCustomItemsHeights() {
  List<double> _itemsHeights = [];
  for (var i = 0; i < (keyitems.length * 2) - 1; i++) {
    if (i.isEven) {
      _itemsHeights.add(40);
    }
    //Dividers indexes will be the odd indexes
    if (i.isOdd) {
      _itemsHeights.add(4);
    }
  }
  return _itemsHeights;
}
