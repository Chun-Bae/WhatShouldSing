//package
import 'package:flutter/material.dart';
//lib
import '../models/song_info.dart';
import '../models/favorite_info.dart';
import '../services/firestore_service.dart';

class SongsState with ChangeNotifier {
  List<SongInfo> songsList = [];
  List<String> favorites = [];
  List<bool> checked = [];

  void setFavoritesList(List<String> favorite) {
    favorites = favorite;
    notifyListeners();
  }

  void setSongsList(List<SongInfo> loadedSongs) {
    songsList = loadedSongs;
    checked = List.generate(songsList.length, (index) => false);
    notifyListeners();
  }

  void addSong(SongInfo songInfo) async {
    songsList.add(songInfo);
    notifyListeners();
  }

  void addFavorite(String favorite) async {
    favorites.add(favorite);
    notifyListeners();
  }

  void updateSong(SongInfo songInfo, int index) async {
    songsList[index] = songInfo;
    notifyListeners();
  }

  void deleteSelectedItems() async {
    List<SongInfo> itemsToRemove = [];
    for (int i = 0; i < checked.length; i++) {
      if (checked[i]) {
        itemsToRemove.add(songsList[i]);
      }
    }

    // Firestore에서 해당 문서 삭제
    for (var song in itemsToRemove) {
      if (song.documentId != null) {
        await songsCollection.doc(song.documentId).delete();
        print("Document with ID: ${song.documentId} deleted");
      }
      print("Document with ID: ${song.documentId}");
    }

    // 로컬 목록에서 항목 삭제 및 상태 업데이트
    songsList.removeWhere((song) => itemsToRemove.contains(song));
    checked = List.generate(songsList.length, (index) => false);
    notifyListeners();
  }

  void initializationSong() async {
    songsList = [];
    notifyListeners();
  }
}

class FavoritesState with ChangeNotifier {
  List<FavoriteInfo> favoriteList = [];
}
