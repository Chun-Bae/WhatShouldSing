import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class MainAppDrawer extends StatelessWidget {
  const MainAppDrawer({super.key});
  final String nickname = "bull";
  final String email = "dbtjrdla2056@naver.com";
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // ListView의 기본 패딩을 제거합니다.
        children: <Widget>[
          UserAccountsDrawerHeader(
            // UserAccountsDrawerHeader를 사용하여 더 풍부한 UI를 제공합니다.
            accountName: Text('$nickname님, 좋은하루 되세요!'),
            accountEmail: Text(email), // 이메일 정보가 없으므로 null로 설정합니다.
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                nickname[0].toUpperCase(), // 닉네임의 첫 글자를 사용합니다.
                style: TextStyle(fontSize: 40.0, color: themeColors[3]),
              ),
            ),
            decoration: BoxDecoration(
              color: themeColors[3],
            ),
          ),
          ListTile(
            leading: Icon(Icons.star, color: themeColors[1]),
            title: Text('즐겨찾기'),
            onTap: () {
              // 탭 이벤트 처리
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: themeColors[1]),
            title: Text('설정'),
            onTap: () {
              // 탭 이벤트 처리
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: themeColors[1]),
            title: Text('정보'),
            onTap: () {
              // 탭 이벤트 처리
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: themeColors[1]),
            title: Text('로그아웃'),
            onTap: () {
              // 탭 이벤트 처리
            },
          ),
        ],
      ),
    );
  }
}
