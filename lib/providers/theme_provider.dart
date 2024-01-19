import 'package:flutter/material.dart';

class UIState with ChangeNotifier {
  bool isSelectionMode = false;

  void toggleSelectionMode() {
    isSelectionMode = !isSelectionMode;
    notifyListeners();
  }
}