//package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_should_sing/providers/theme_provider.dart';
//lib
import '../utils/colors.dart';
import '../../providers/state_provider.dart';
import '../../services/firestore_service.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Column의 주요 축 크기를 최소로 설정
        children: const <Widget>[
          DynamicExpansionTileList(),
        ],
      ),
    );
  }
}

class DynamicExpansionTileList extends StatefulWidget {
  const DynamicExpansionTileList({Key? key}) : super(key: key);

  @override
  _DynamicExpansionTileListState createState() =>
      _DynamicExpansionTileListState();
}

class _DynamicExpansionTileListState extends State<DynamicExpansionTileList> {
  final directoryTitleController = TextEditingController();

  @override
  void dispose() {
    directoryTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final songsState = Provider.of<SongsState>(context);
    final isSelectionMode = Provider.of<UIState>(context).isSelectionMode;
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: themeColors[3],
              primary: Colors.white,
              minimumSize: Size.fromHeight(50),
              padding: EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: themeColors[5],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 5),
                      TextField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: directoryTitleController,
                        decoration: InputDecoration(
                          hintText: '폴더 이름',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              firebaseAddFavorite(
                                  directoryTitleController.text);
                              songsState
                                  .addFavorite(directoryTitleController.text);
                              directoryTitleController.clear();
                              Navigator.pop(context);
                            },
                            child: const Text('추가'),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: themeColors[3],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('취소'),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: themeColors[3],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            child: Text('폴더 추가'),
          ),
        ),
        // Expanded 제거 및 ListView.builder 직접 사용
        isSelectionMode
            ? ListView.builder(
                shrinkWrap: true, // ListView가 자신의 내용에 맞게 크기를 조정하도록 함
                physics:
                    NeverScrollableScrollPhysics(), // SingleChildScrollView와 충돌 방지
                itemCount: songsState.favorites.length,
                itemBuilder: (context, index) {
                  final item = songsState.favorites[index];
                  return Card(
                    elevation: 10.0,
                    color: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // 텍스트에 패딩을 추가
                      child: Row(
                        children: [
                          Checkbox(
                            value: songsState.favoritesChecked[index],
                            activeColor: themeColors[3],
                            onChanged: (bool? value) {
                              setState(() {
                                // checkbox 색지정을 위해 setState사용
                                songsState.favoritesChecked[index] = value!;
                              });
                            },
                            shape: CircleBorder(),
                          ),
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : ListView.builder(
                shrinkWrap: true, // ListView가 자신의 내용에 맞게 크기를 조정하도록 함
                physics:
                    NeverScrollableScrollPhysics(), // SingleChildScrollView와 충돌 방지
                itemCount: songsState.favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 10.0,
                    color: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ExpansionTile(
                      title: Text('${songsState.favorites[index]}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      backgroundColor: themeColors[0],
                      iconColor: themeColors[1],
                      childrenPadding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      leading: Icon(Icons.folder),
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed: () {
                                  //삭제 기능 구현
                                },
                                icon: Icon(
                                  Icons.delete_rounded,
                                  color: const Color.fromARGB(255, 65, 65, 65),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
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
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("뜨거운 여름밤은 가고 남은 건 볼품 없지만"),
                                Text('TJ'),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('잔나비'),
                                Text('54355'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ],
    );
  }
}
