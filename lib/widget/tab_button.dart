import 'package:flutter/material.dart';

class TabButtons extends StatelessWidget {
  final int selectedTabIndex;
  final int index;
  final String text;
  final Function(int) onTap;

  const TabButtons(
    this.selectedTabIndex,
    this.index,
    this.text,
    this.onTap, {
    super.key,
    // Key? key,
  });

  @override
  Widget build(BuildContext context) {
    Color getButtonColor(int tabIndex) {
      return selectedTabIndex == tabIndex ? Colors.black : Colors.transparent;
    }

    Color getTextColor(int tabIndex) {
      return selectedTabIndex == tabIndex ? Colors.white : Colors.black;
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: getButtonColor(index),
            border: Border(
              bottom: BorderSide(
                color: getButtonColor(index),
                width: 1.5,
              ),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextButton(
            onPressed: () {
              onTap(index);
            },
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: getTextColor(index),
                fontFamily: 'RalewayVariableFont',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
