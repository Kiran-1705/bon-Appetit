import 'package:flutter/material.dart';

class TabButtons extends StatelessWidget {
  final int selectedTabIndex;
  final int index;
  final String text;
  final Function(int) onTap;

  const TabButtons(this.selectedTabIndex, this.index, this.text, this.onTap,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
                  selectedTabIndex == index ? Colors.black : Colors.transparent,
              width: 1.5,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () {
            onTap(index);
          },
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Outfit'),
          ),
        ),
      ),
    );
  }
}
