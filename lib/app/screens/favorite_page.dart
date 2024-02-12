//package
import 'package:flutter/material.dart';
//lib
import '../utils/colors.dart';

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
  List<Widget> expansionTileList = [];
  bool isExpanded = false;

  void _addExpansionTile() {
    int newIndex = expansionTileList.length + 1;
    Widget newTile = Card(
      shape: RoundedRectangleBorder(
        //borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isExpanded ? themeColors[0] : Colors.grey, // 펼쳐졌을 때와 아닐 때의 색상
          width: 2,
        ),
      ),
      child: ExpansionTile(
        title: Text('${directoryTitleController.text}',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey[200],
        iconColor: themeColors[1],
        childrenPadding: EdgeInsets.all(10),
        leading: Icon(Icons.folder),
        children: <Widget>[
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

    setState(() {
      expansionTileList.add(newTile);
    });
  }

  @override
  void dispose() {
    directoryTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                            // Use OutlineInputBorder to achieve rounded corners
                            borderRadius: BorderRadius.circular(
                                20.0), // Adjust the corner radius
                            borderSide: BorderSide.none, // No border side
                          ),
                          filled: true, // Enable the fillColor to be effective
                          fillColor: const Color.fromARGB(255, 228, 228,
                              228), // Fill color for the TextField
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              _addExpansionTile();
                              directoryTitleController.clear();
                              Navigator.pop(context);
                            },
                            child: const Text('추가'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('취소'),
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
        ListView.builder(
          shrinkWrap: true, // ListView가 자신의 내용에 맞게 크기를 조정하도록 함
          physics:
              NeverScrollableScrollPhysics(), // SingleChildScrollView와 충돌 방지
          itemCount: expansionTileList.length,
          itemBuilder: (BuildContext context, int index) {
            return expansionTileList[index];
          },
        ),
      ],
    );
  }
}
