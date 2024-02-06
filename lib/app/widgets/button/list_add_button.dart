//package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//lib
import '../../utils/colors.dart';
import '../../screens/add_page.dart';
import '../../../providers/state_provider.dart';

class MainAddButton extends StatefulWidget {
  @override
  _MainAddButton createState() => _MainAddButton();
}

class _MainAddButton extends State<MainAddButton> {
  Widget build(BuildContext context) {
    final songsState = Provider.of<SongsState>(context);
    return Container(
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
            songsState.checked =
                List.generate(songsState.songsList.length, (index) => false);
          });
        },
      ),
    );
  }
}
