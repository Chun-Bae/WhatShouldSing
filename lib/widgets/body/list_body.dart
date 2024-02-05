import 'package:flutter/material.dart';
import 'package:what_should_sing/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../../screens/edit_page.dart';
import '../../utils/colors.dart';
import '../../providers/state_provider.dart';

class ListTileBody extends StatefulWidget {
  @override
  _ListTileBody createState() => _ListTileBody();
}

class _ListTileBody extends State<ListTileBody> {
  Widget build(BuildContext context) {
    final isSelectionMode = Provider.of<UIState>(context).isSelectionMode;
    final checked = Provider.of<SongsState>(context).checked;
    final songsList = Provider.of<SongsState>(context).songsList;

    return ListView.builder(
      itemCount: songsList.length,
      itemBuilder: (context, index) {
        final songInfo = songsList[index];
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
            onTap: () {
              // 수정 페이지로 이동하면서 songInfo 객체 전달
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditPage(songInfo: songInfo, index: index),
                ),
              );
            },
            leading: isSelectionMode
                ? Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: checked[index],
                      activeColor: themeColors[3],
                      onChanged: (bool? value) {
                        setState(() {
                          // checkbox 색지정을 위해 setState사용
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
                Text(songsList[index].isTJ
                    ? 'TJ'
                    : songsList[index].isKY
                        ? '금영'
                        : ''),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(songsList[index].artist),
                Text(songsList[index].songNumber),
              ],
            ),
          ),
        );
      },
    );
  }
}
