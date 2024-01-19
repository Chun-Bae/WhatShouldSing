import 'package:flutter/material.dart';

// 색상 배열 정의
final List<Color> themeColors = [
  Color(0xffFDEEDC), 
  Color(0xffFFD8A9), 
  Color(0xffF1A661), 
  Color(0xffE38B29), 
];

class SongInfo {
  String song;
  String artist;
  String number;
  bool isTJ;
  bool isKY;

  SongInfo({required this.song, required this.artist, required this.number,this.isTJ = false,this.isKY = false});
}

List<SongInfo> songsList = [];
List<bool> checked = List.generate(songsList.length, (index) => false);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '뭐부르지',
      debugShowCheckedModeBanner: false,
      home: KaraokeListScreen(),
    );
  }
}

class KaraokeListScreen extends StatefulWidget {
  @override
  _KaraokeListScreenState createState() => _KaraokeListScreenState();
}

class _KaraokeListScreenState extends State<KaraokeListScreen> {


  bool isSelectionMode = false;

  void toggleSelectionMode() {
    setState(() {
      isSelectionMode = !isSelectionMode;
    });
  }

  void deleteSelectedItems() {
    setState(() {
      // 체크된 항목들을 삭제합니다.
      for (int i = checked.length - 1; i >= 0; i--) {
        if (checked[i]) {
          songsList.removeAt(i);
        }
      }
      // 삭제 후 선택 모드를 해제합니다.
      isSelectionMode = false;
      checked = List.generate(songsList.length, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(3)),
          child: AppBar(
            centerTitle: true,

            backgroundColor: themeColors[2],
            title: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '뭐부',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  TextSpan(
                      text: '르지',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
            ),
            actions: [
              if (!isSelectionMode)
                PopupMenuButton<String>(
                  offset: Offset(0, 30),
                  onSelected: (value) {
                    if (value == 'delete') {
                      toggleSelectionMode();
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        height: 20,
                        value: 'delete',
                        child: Text('삭제'),
                      ),
                    ];
                  },
                  icon: Icon(Icons.more_horiz),
                ),
              if (isSelectionMode)
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      isSelectionMode = false;
                      checked = List.generate(songsList.length, (index) => false);
                    });
                  },
                ),
            ],
          ),
        ),
      ),
      body: songsList.isEmpty
      ? Center(
          child: Text("노래를 추가해보세요!", style: TextStyle(fontSize: 18)),
        )
      : ListView.builder(
        itemCount: songsList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              color: themeColors[1],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: isSelectionMode
                  ? Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                        value: checked[index],
                        onChanged: (bool? value) {
                          setState(() {
                            checked[index] = value!;
                          });
                        },
                        shape: CircleBorder(),
                      ),
                    )
                  : null,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,         
                children: <Widget>[
                  Text(songsList[index].song),
                  Text(songsList[index].isTJ ? 'TJ' : songsList[index].isKY ? '금영': ''),
                ],              
              ),
              
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,         
                children: <Widget>[
                  Text(songsList[index].artist),
                  Text(songsList[index].number),
                ],              
              ),
            ),
          );
        },
      ),
  
      bottomNavigationBar: isSelectionMode
          ? BottomAppBar(
              height: 60.0,
              child: InkWell(
                onTap: () {
                  toggleSelectionMode();
                  deleteSelectedItems();
                },
                child: Container(
                  child: Center(
                    child: Text('삭제',
                        style: TextStyle(fontSize: 18, color: themeColors[3])),
                  ),
                ),
              ),
            )
          : null,
      floatingActionButton: isSelectionMode
          ? null
          : Container(
              width: 46.0,
              height: 46.0,
              child: FloatingActionButton(
                backgroundColor: themeColors[3],
                child: Icon(Icons.add),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                ),
                onPressed: () {
                  // 여기에서 새 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPage()),
                  ).then((_) {
                    // 뒤로 가기가 실행된 후 이곳에서 setState를 호출하여 위젯을 새로고침합니다.
                    setState(() {
                      checked = List.generate(songsList.length, (index) => false);
                    });
                  });
                },
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController songController = TextEditingController();
  final TextEditingController artistController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  bool isTJ = true;
  bool isKY = false;
  
  void addSong() {
    if (songController.text.isEmpty || artistController.text.isEmpty || numberController.text.isEmpty) {
      // 필드 중 하나라도 비어 있으면 SnackBar를 표시합니다.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('모든 입력칸을 채워주세요.'),
          duration: Duration(seconds: 2), // 메시지 표시 시간
        ),
      );
    } else {
        setState(() {
          String song = songController.text;
          String artist = artistController.text;
          String number = numberController.text;

          if (song.isNotEmpty && artist.isNotEmpty && number.isNotEmpty) {
            songsList.add(SongInfo(song: song, artist: artist, number: number,isTJ:isTJ, isKY:isKY));
            songController.clear();
            artistController.clear();
            numberController.clear();
          }
        });
        Navigator.pop(context); // 뒤로 가기
      }
    }
  
    InputDecoration _roundedInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      // 포커스 됐을 때 테두리
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: Colors.blue),
        ),
      );
     }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(3)),
          child: AppBar(
            centerTitle: true,
            elevation: 1,
            backgroundColor: themeColors[2],
            title: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '뭐부',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  TextSpan(
                      text: '르지',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: songController,
                decoration: _roundedInputDecoration('노래 이름'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: artistController,
                decoration: _roundedInputDecoration('가수'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: numberController,
                decoration: _roundedInputDecoration('번호'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: isTJ ? themeColors[3] : Colors.white,
                    primary: isTJ ? Colors.white : Colors.black,
                    minimumSize: Size(120, 45),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: isTJ ? Colors.transparent : Colors.grey),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isTJ = true;
                      isKY = false;
                    });
                  },
                  child: Text('TJ'),
                ),
                  
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: isKY ? themeColors[3] : Colors.white,
                    primary: isKY ? Colors.white : Colors.black,
                    minimumSize: Size(120, 45),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: isKY ? Colors.transparent : Colors.grey),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isTJ = false;
                      isKY = true;
                    });
                  },
                  child: Text('금영'),
                ),
                                   
                ],
              ),
              SizedBox(height: 200),
              ElevatedButton(
                style: TextButton.styleFrom(
                    backgroundColor:  themeColors[3],
                    primary: Colors.white,  
                    minimumSize: Size(140, 50),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                child: Text('추가',
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                onPressed: () {
                  addSong();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}