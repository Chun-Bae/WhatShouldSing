import 'package:flutter/material.dart';
import '../widgets/appbar/edit_page_appbar.dart';
import '../models/song_info.dart';
import '../utils/colors.dart';
import '../providers/state_provider.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  final SongInfo songInfo; // final로 선언하여 변경 불가능하게 함
  final int index;
  const EditPage({Key? key, required this.songInfo, required this.index}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController songController = TextEditingController();
  TextEditingController artistController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  bool isTJ = true;
  bool isKY = false;
  @override
  void initState() {
    super.initState();
    // TextEditingController에 노래 정보를 초기값으로 설정
    songController = TextEditingController(text: widget.songInfo.song);
    artistController = TextEditingController(text: widget.songInfo.artist);
    numberController = TextEditingController(text: widget.songInfo.songNumber);
    isTJ = widget.songInfo.isTJ;
    isKY = widget.songInfo.isKY;
  }

  @override
  void dispose() {
    // 컨트롤러 사용이 끝났을 때 해제
    songController.dispose();
    artistController.dispose();
    numberController.dispose();
    super.dispose();
  }

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
    // UI 구성 및 songInfo 사용
    return Scaffold(
      appBar: EditPageAppBar(),
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
                child: Text('변경',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
                onPressed: () async {
                  if (!controllerIsEmpty()) {
                    // String? documentId = await _firebaseAddSong(
                    //   songController.text,
                    //   artistController.text,
                    //   numberController.text,
                    //   isTJ,
                    //   isKY,
                    // );
                    songsState.updateSong(SongInfo(
                      song: songController.text,
                      artist: artistController.text,
                      songNumber: numberController.text,
                      isTJ: isTJ,
                      isKY: isKY,
                    ),widget.index);
                    controllerClear();
                    print("노래 정보가 성공적으로 변경되었습니다.");
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
