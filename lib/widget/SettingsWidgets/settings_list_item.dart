import 'package:flutter/material.dart';

Widget buildListItem(String title, IconData icon, VoidCallback onPressed) {
  return TextButton(
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 21, fontFamily: 'Kanit', color: Colors.black),
        ),
        Icon(Icons.arrow_forward, color: Colors.black),
      ],
    ),
  );
}
