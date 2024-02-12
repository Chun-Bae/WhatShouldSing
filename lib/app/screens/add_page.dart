import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/colors.dart';
import '../../models/song_info.dart';
import '../widgets/appbar/add_page_appbar.dart';
import '../../providers/state_provider.dart';
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

Future<String?> _firebaseAddSong(
    String song, String artist, String songNumber, bool isTJ, bool isKY) async {
// 보안 규칙 추가 필수
// rules_version = '2';

// service cloud.firestore {
//   match /databases/{database}/documents {
//     match /{document=**} {
//       allow read, write: if request.auth != null;
//     }
//   }
// }

  try {
    // Firestore에 사용자 ID를 포함한 노래 정보를 추가하는 문서 생성
    DocumentReference docRef = await subCollection.add({
      'userId': userId, // 현재 사용자의 UID 추가
      'song': song,
      'artist': artist,
      'songNumber': songNumber,
      'isTJ': isTJ,
      'isKY': isKY,
      'createdAt':
          FieldValue.serverTimestamp(), // Firestore 서버 시간을 기준으로 타임스탬프 생성
    });
    // 생성된 문서의 ID를 가져옴
    String documentId = docRef.id;
    // 동일한 문서에 documentId 필드를 추가하거나 업데이트
    await docRef.update({
      'documentId': documentId,
    });

    print("노래 정보가 성공적으로 추가되었습니다.");
    return documentId;
  } catch (e) {
    print("노래 정보 추가 중 오류 발생: $e");
  }
  return null;
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
  
  void dispose() {
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
                onPressed: () async {
                  if (!controllerIsEmpty()) {
                    String? documentId = await _firebaseAddSong(
                      songController.text,
                      artistController.text,
                      numberController.text,
                      isTJ,
                      isKY,
                    );
                    songsState.addSong(SongInfo(
                      song: songController.text,
                      artist: artistController.text,
                      songNumber: numberController.text,
                      isTJ: isTJ,
                      isKY: isKY,
                      documentId: documentId as String?,
                    ));
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
