import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'package:provider/provider.dart';
import '../../../providers/state_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/nav_tap_provider.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  MainAppbar({Key? key, required this.bottom}) : super(key: key);
  Widget? buildActionBasedOnIndex(BuildContext context) {
    final uiState = Provider.of<UIState>(context);
    final songsState = Provider.of<SongsState>(context);
    final selectedIndex = Provider.of<NavTapState>(context).selectedIndex;

    switch (selectedIndex) {
      case 0:
        return (!uiState.isSelectionMode)
            ? Container(
                child: IconButton(
                  onPressed: () {
                    uiState.toggleSelectionMode();
                  },
                  icon: Icon(
                    Icons.delete_rounded,
                    color: const Color.fromARGB(255, 65, 65, 65),
                  ),
                ),
              )
            : Container(
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    uiState.toggleSelectionMode();
                    songsState.checked = List.generate(
                        songsState.songsList.length, (index) => false);
                  },
                ),
              );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(3)),
        child: AppBar(
          centerTitle: true,
          backgroundColor: themeColors[2],
          bottom: bottom,
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
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          actions: <Widget>[
            if (buildActionBasedOnIndex(context) != null)
              buildActionBasedOnIndex(context)!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      this.bottom == null ? Size.fromHeight(50.0) : Size.fromHeight(110.0);
}
