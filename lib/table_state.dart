import 'package:flutter/material.dart';

class TableState extends ChangeNotifier {

  TableState() {
    _init();
  }
  var _list = <String>[
    '08:00',
    '12:00',
    '13:00',
    '17:00',
    '00:00',
    '00:00',
    '00:00',
    '00:00',
  ];

  final _mapIndex = <String, bool>{};

  List<String> get list => _list;

  Map<String, bool> get mapIndex => _mapIndex;

  void setClicked(int? position, int? index) {
    _mapIndex.updateAll((key, value) => value = false);

    _mapIndex["$position,$index"] = true;

    notifyListeners();
  }

  void _init() {
    for (var i = 0; i < 30; i++) {
      for (final (j, item) in list.indexed) {
        mapIndex.addAll({"$i,$j": false});
      }
    }
  }
}
