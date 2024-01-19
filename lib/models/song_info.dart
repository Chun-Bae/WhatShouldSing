class SongInfo {
  String song;
  String artist;
  String number;
  bool isTJ;
  bool isKY;

  SongInfo({required this.song, required this.artist, required this.number, this.isTJ = false, this.isKY = false});

  // JSON으로 객체를 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'song': song,
      'artist': artist,
      'number': number,
      'isTJ': isTJ,
      'isKY': isKY,
    };
  }

  // JSON에서 객체로 변환하는 팩토리 생성자
  factory SongInfo.fromJson(Map<String, dynamic> json) {
    return SongInfo(
      song: json['song'],
      artist: json['artist'],
      number: json['number'],
      isTJ: json['isTJ'],
      isKY: json['isKY'],
    );
  }
}