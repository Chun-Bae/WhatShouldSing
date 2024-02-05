
// Future<List<SongInfo>> loadSongs() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   // 'songs' 키로 저장된 JSON 문자열 리스트를 로드
//   List<String>? jsonSongs = prefs.getStringList('songs');
//   // JSON 문자열 리스트를 SongInfo 객체 리스트로 변환
//   return jsonSongs
//           ?.map((jsonSong) => SongInfo.fromJson(json.decode(jsonSong)))
//           .toList() ??
//       [];
// }

// Future<void> saveSongs(List<SongInfo> songs) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   // SongInfo 객체 리스트를 JSON 문자열 리스트로 변환
//   List<String> jsonSongs =
//       songs.map((song) => json.encode(song.toJson())).toList();
//   // JSON 문자열 리스트를 'songs' 키로 저장
//   await prefs.setStringList('songs', jsonSongs);
// }
