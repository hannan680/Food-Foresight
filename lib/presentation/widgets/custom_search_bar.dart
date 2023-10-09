import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function()? onTapTrailing;

  CustomSearchBar({Key? key, this.onChanged, this.onTapTrailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Color.fromARGB(255, 116, 115, 115)),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: "Search here",
                enabledBorder: InputBorder.none, // Remove underline
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 116, 115, 115),
                ),
              ),
            ),
          ),
          GestureDetector(
              onTap: onTapTrailing,
              child: Icon(Icons.sort, color: Colors.black)),
        ],
      ),
    );
  }
}
