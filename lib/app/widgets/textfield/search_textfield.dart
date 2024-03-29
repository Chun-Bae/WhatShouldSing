//package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//lib
import '../../../providers/search_provider.dart';

class SearchTextfield extends StatefulWidget implements PreferredSizeWidget {
  const SearchTextfield({super.key});

  @override
  State<SearchTextfield> createState() => _SearchTextfieldState();
  Size get preferredSize => new Size.fromHeight(60.0);
}

class _SearchTextfieldState extends State<SearchTextfield> {
  final TextEditingController searchTextController = TextEditingController();
  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchText = Provider.of<SearchState>(context);
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
                controller: searchTextController,
                decoration: InputDecoration(
                  hintText: '노래 검색...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    child: const Icon(
                      Icons.cancel,
                    ),
                    onTap: () =>
                        {searchTextController.clear(), searchText.clear()},
                  ),

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
                onChanged: (text) {
                  searchText.setSearchText(text);
                },
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
