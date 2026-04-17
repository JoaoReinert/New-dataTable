import 'package:flutter/material.dart';

class TableState<T> extends ChangeNotifier {
  TableState(this.data) {
    _init();
  }

  final List<T> data;
  final controller = TextEditingController();
  final focusNode = FocusNode();
  final _mapIndex = <(int, int), bool>{};

  List<T> get list => data;

  Map<(int, int), bool> get mapIndex => _mapIndex;

  void setClicked(int position, int index) {
    _mapIndex.updateAll((key, value) => value = false);
    _mapIndex[(position, index)] = true;
    notifyListeners();
  }

  void _init() {
    for (var i = 0; i < 30; i++) {
      for (final (j, item) in list.indexed) {
        mapIndex.addAll({(i, j): false});
      }
    }
  }
}
