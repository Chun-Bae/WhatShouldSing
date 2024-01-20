import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../models/song_info.dart';
import '../widgets/appbar/add_page_appbar.dart';
import '../providers/state_provider.dart';

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

  bool controllerIsEmpty() {
    if (songController.text.isEmpty ||
        artistController.text.isEmpty ||
        numberController.text.isEmpty) {
      // 필드 중 하나라도 비어 있으면 SnackBar를 표시합니다.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('모든 입력칸을 채워주세요.'),
          duration: Duration(seconds: 2), // 메시지 표시 시간
        ),
      );
      return true;
    } else {
      return false;
    }
  }

  void controllerClear() {
    songController.clear();
    artistController.clear();
    numberController.clear();
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
    final songsState = Provider.of<SongsState>(context);

    return Scaffold(
      appBar: AddPageAppBar(),
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
                        side: BorderSide(
                            color: isTJ ? Colors.transparent : Colors.grey),
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
                        side: BorderSide(
                            color: isKY ? Colors.transparent : Colors.grey),
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
                  backgroundColor: themeColors[3],
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
                  if (!controllerIsEmpty()) {
                    songsState.addSong(SongInfo(
                        song: songController.text,
                        artist: artistController.text,
                        number: numberController.text,
                        isTJ: isTJ,
                        isKY: isKY));
                    controllerClear();
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
