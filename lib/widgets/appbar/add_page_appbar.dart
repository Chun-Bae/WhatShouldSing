import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class AddPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(3)),
        child: AppBar(
          centerTitle: true,
          elevation: 1,
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
