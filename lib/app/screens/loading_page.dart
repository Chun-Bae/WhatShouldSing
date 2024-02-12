//package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//lib
import 'main_page.dart';
import '../utils/colors.dart';
import '../widgets/textfield/title_wss.dart';
import '../widgets/logo/mike_logo.dart';
import '../../models/song_info.dart';
import '../../providers/state_provider.dart';
import '../../services/firestore_service.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _loadSongs();
    _navigateToLogin();
  }

  void _loadSongs() async {
    List<SongInfo> loadedSongs = await fetchSongs();
    Provider.of<SongsState>(context, listen: false).setSongsList(loadedSongs);
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 1), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColors[2],
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            TitleWSS(),
            MikeLogo(x: -16, y: -30),
          ],
        ),
      ),
    );
  }
}
