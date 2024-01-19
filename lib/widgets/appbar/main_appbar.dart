import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'package:provider/provider.dart';
import '../../providers/state_provider.dart';
import '../../providers/theme_provider.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  MainAppbar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final uiState = Provider.of<UIState>(context);
    final songsState = Provider.of<SongsState>(context);
    
    return PreferredSize(
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
              (!uiState.isSelectionMode) ?
                PopupMenuButton<String>(
                  offset: Offset(0, 30),
                  onSelected: (value) {
                    if (value == 'delete') {
                      uiState.toggleSelectionMode();
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
                )
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {               
                    uiState.toggleSelectionMode();
                    songsState.checked = List.generate(songsState.songsList.length, (index) => false);                  
                  },
                ),
            ],
          ),
        ),
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}