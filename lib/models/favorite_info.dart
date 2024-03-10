class FavoriteInfo {
  String name;
  String song;
  String artist;
  String songNumber;

  bool isTJ;
  bool isKY;

  FavoriteInfo(
      {required this.name,
      required this.song,
      required this.artist,
      required this.songNumber,
      this.isTJ = false,
      this.isKY = false});
}
