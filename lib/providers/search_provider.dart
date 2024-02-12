//package
import 'package:flutter/material.dart';

class SearchState with ChangeNotifier {
  String searchText = "";

  void setSearchText(String searchText) {
    this.searchText = searchText;
    notifyListeners();
  }

  void clear() {
    this.searchText = "";
    notifyListeners();
  }
}
