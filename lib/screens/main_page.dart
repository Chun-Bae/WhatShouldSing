import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_should_sing/widgets/button/main_add_button.dart';

import '../providers/state_provider.dart';
import '../providers/theme_provider.dart';

import '../widgets/appbar/main_appbar.dart';
import '../widgets/body/empty_body.dart';
import '../widgets/body/list_body.dart';
import '../widgets/bottombar/delete_bar.dart';

class KaraokeListScreen extends StatefulWidget {
  @override
  _KaraokeListScreenState createState() => _KaraokeListScreenState();
}

class _KaraokeListScreenState extends State<KaraokeListScreen> {
  @override
  Widget build(BuildContext context) {
    final isSelectionMode = Provider.of<UIState>(context).isSelectionMode;
    final songsList = Provider.of<SongsState>(context).songsList;

    return Scaffold(
      backgroundColor: Colors.white,
      //AppBar
      appBar: MainAppbar(),
      //Body
      body: songsList.isEmpty ? EmptyBody() : ListTileBody(),
      //BottomBar
      bottomNavigationBar: isSelectionMode ? DeleteBar() : null,
      //AddButton
      floatingActionButton: isSelectionMode ? null : MainAddButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}