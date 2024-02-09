import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_should_sing/app/widgets/button/list_add_button.dart';

import '../../providers/state_provider.dart';
import '../../providers/theme_provider.dart';

import '../widgets/appbar/main_appbar.dart';
import '../widgets/body/empty_body.dart';
import '../widgets/body/list_body.dart';
import '../widgets/bottombar/delete_bar.dart';
import '../widgets/bottombar/list_tap_bar.dart';
import '../widgets/navigation/main_bar_drawer.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    final isSelectionMode = Provider.of<UIState>(context).isSelectionMode;
    final songsList = Provider.of<SongsState>(context).songsList;

    return Scaffold(
      backgroundColor: Colors.white,
      //AppBar
      appBar: MainAppbar(),
      drawer: MainAppDrawer(),
      //Body
      body: songsList.isEmpty ? EmptyBody() : ListTileBody(),
      //BottomBar
      bottomNavigationBar: isSelectionMode ? DeleteBar() : ListTapBar(),
      //AddButton
      floatingActionButton: isSelectionMode ? null : MainAddButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
