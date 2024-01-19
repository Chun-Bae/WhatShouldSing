import 'package:flutter/material.dart';
import 'package:what_should_sing/providers/theme_provider.dart';
import '../../utils/colors.dart';
import '../../providers/state_provider.dart';
import 'package:provider/provider.dart';

class ListTileBody extends StatelessWidget{
  Widget build(BuildContext context) {
    final isSelectionMode = Provider.of<UIState>(context).isSelectionMode;
    final songsList = Provider.of<SongsState>(context).songsList;
    final checked = Provider.of<SongsState>(context).checked;
    return ListView.builder(
      
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
                            checked[index] = value!;
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
      );
  }
}