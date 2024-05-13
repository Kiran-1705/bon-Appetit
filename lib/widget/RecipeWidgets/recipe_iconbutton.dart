import 'package:flutter/material.dart';
import 'package:bon_appetit/screen/home/screen_search.dart';
import 'package:bon_appetit/screen/home/screen_sort.dart';

class IconButtons extends StatelessWidget {
  const IconButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenSearchRecipe(),
              ),
            );
          },
          icon: const Icon(Icons.search, size: 33, color: Colors.white),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenSort(),
              ),
            );
          },
          icon: const Icon(Icons.sort, size: 33, color: Colors.white),
        ),
      ],
    );
  }
}
