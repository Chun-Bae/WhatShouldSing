import 'package:flutter/material.dart';
import '../models/song_info.dart';

class SongsState with ChangeNotifier {
  List<SongInfo> songsList = [];
  List<bool> checked = [];

  void addSong(SongInfo songInfo) {
    songsList.add(songInfo);
    notifyListeners();
  }

  void deleteSelectedItems() {
    // 체크된 항목들을 삭제합니다.
    for (int i = checked.length - 1; i >= 0; i--) {
      if (checked[i]) {
        songsList.removeAt(i);
      }
    }
    checked = List.generate(songsList.length, (index) => false);
    notifyListeners();
  }
}
