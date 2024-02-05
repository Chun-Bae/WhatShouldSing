import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/song_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

User? currentUser = FirebaseAuth.instance.currentUser;
// 상위 컬렉션과 문서 ID를 지정
final String parentCollectionPath = 'users';

final String userId =
    FirebaseAuth.instance.currentUser?.uid ?? ""; // 현재 사용자의 UID

// 서브컬렉션과 새 문서를 추가, 'songs'라는 서브컬렉션에 노래 정보를 추가
final CollectionReference subCollection =
    db.collection(parentCollectionPath).doc(userId).collection('songs');

class SongsState with ChangeNotifier {
  List<SongInfo> songsList = [];
  List<bool> checked = [];

  void setSongsList(List<SongInfo> loadedSongs) {
    songsList = loadedSongs;
    checked = List.generate(songsList.length, (index) => false);
    notifyListeners();
  }

  void addSong(SongInfo songInfo) async {
    songsList.add(songInfo);
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
        await subCollection.doc(song.documentId).delete();
        print("Document with ID: ${song.documentId} deleted");
      }
      print("Document with ID: ${song.documentId}");
    }

    // 로컬 목록에서 항목 삭제 및 상태 업데이트
    songsList.removeWhere((song) => itemsToRemove.contains(song));
    checked = List.generate(songsList.length, (index) => false);
    notifyListeners();
  }


}
