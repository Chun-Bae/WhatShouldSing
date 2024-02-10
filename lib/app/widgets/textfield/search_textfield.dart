//package
import 'package:flutter/material.dart';

class SearchTextfield extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Adjust the padding to add margins

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  hintText: '노래 검색...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    // Use OutlineInputBorder to achieve rounded corners
                    borderRadius:
                        BorderRadius.circular(20.0), // Adjust the corner radius
                    borderSide: BorderSide.none, // No border side
                  ),
                  filled: true, // Enable the fillColor to be effective
                  fillColor: const Color.fromARGB(
                      255, 228, 228, 228), // Fill color for the TextField
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}
