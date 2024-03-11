import 'package:flutter/material.dart';
import 'package:what_should_sing/providers/theme_provider.dart';
import '../../utils/colors.dart';
import '../../../providers/state_provider.dart';
import '../../../providers/nav_tap_provider.dart';
import 'package:provider/provider.dart';

class DeleteBar extends StatelessWidget {
  Widget build(BuildContext context) {
    final uiState = Provider.of<UIState>(context);
    final songsState = Provider.of<SongsState>(context);
    final navTapState = Provider.of<NavTapState>(context);

    return BottomAppBar(
      height: 60.0,
      child: InkWell(
        onTap: () {
          uiState.toggleSelectionMode();
          if (navTapState.selectedIndex == 0)
            songsState.deleteSelectedItems();
          else if (navTapState.selectedIndex == 1)
            songsState.deleteSelectedFavorites();
        },
        child: Container(
          child: Center(
            child: Text('삭제',
                style: TextStyle(fontSize: 18, color: themeColors[3])),
          ),
        ),
      ),
    );
  }
}
