import 'package:cloud_firestore/cloud_firestore.dart';

class SongInfo {
  String song;
  String artist;
  String songNumber;
  String? createdAt;
  String? userId;
  String? documentId;

  bool isTJ;
  bool isKY;

  SongInfo(
      {required this.song,
      required this.artist,
      required this.songNumber,
      this.createdAt = ' ',
      this.userId = ' ',
      this.documentId,
      this.isTJ = false,
      this.isKY = false});

  // Firestore 문서로부터 SongInfo 객체를 생성하는 팩토리 생성자
  factory SongInfo.fromFirestore(Map<String, dynamic> data) {
    Timestamp timestamp = data['createdAt'] as Timestamp? ??
        Timestamp.now(); // Timestamp를 가져오거나 현재 시간을 기본값으로 사용
    String isoDate = timestamp
        .toDate()
        .toIso8601String(); // DateTime으로 변환 후 ISO 8601 문자열 형식으로 변환

    return SongInfo(
      song: data['song'] as String? ?? '',
      artist: data['artist'] as String? ?? '',
      songNumber: data['songNumber'] as String? ?? '',
      userId: data['userId'] as String? ?? '',
      documentId: data['documentId'] as String? ?? '',
      createdAt: isoDate,
      isTJ: data['isTJ'] as bool? ?? false,
      isKY: data['isKY'] as bool? ?? false,
    );
  }

  // JSON으로 객체를 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'song': song,
      'artist': artist,
      'songNumber': songNumber,
      'createdAt': createdAt,
      'userId': userId,
      'documentId' : documentId,
      'isTJ': isTJ,
      'isKY': isKY,
    };
  }

  // JSON에서 객체로 변환하는 팩토리 생성자
  factory SongInfo.fromJson(Map<String, dynamic> json) {
    return SongInfo(
      song: json['song'],
      artist: json['artist'],
      songNumber: json['songNumber'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      documentId: json['documentId'],
      isTJ: json['isTJ'],
      isKY: json['isKY'],
    );
  }
}
