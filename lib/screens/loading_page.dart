import 'package:flutter/material.dart';
import 'package:what_should_sing/utils/colors.dart';
import '../screens/main_page.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 1), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => KaraokeListScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColors[2],
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '뭐부',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: '르지'),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(-10, -30), // x축은 0, y축을 -10으로 이동
              child: Image.asset(
                'assets/images/mike.png',// <a href="https://www.flaticon.com/kr/free-icons/" title="노래방 아이콘">노래방 아이콘  제작자: Iconjam - Flaticon</a>
                width: 37,
                height: 37,
              ),
            )
          ],
        ),
      ),
    );
  }
}
