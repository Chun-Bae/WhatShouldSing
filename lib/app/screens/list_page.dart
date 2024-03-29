//package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//lib
import '../../providers/state_provider.dart';
import '../../providers/theme_provider.dart';
import '../widgets/body/empty_body.dart';
import '../widgets/body/list_body.dart';
import '../widgets/button/list_add_button.dart';

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
      //Body
      body: songsList.isEmpty ? EmptyBody() : ListTileBody(),
      //AddButton
      floatingActionButton: isSelectionMode ? null : MainAddButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //BottomBar
      // bottomNavigationBar: isSelectionMode ? DeleteBar() : ListTapBar(),
    );
  }
}
