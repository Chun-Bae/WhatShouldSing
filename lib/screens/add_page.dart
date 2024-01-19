import 'package:flutter/material.dart';
import '../utils/colors.dart';




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