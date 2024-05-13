import 'package:flutter/material.dart';

class RecommendedText extends StatelessWidget {
  const RecommendedText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('For You',
                  style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit')),
              Text('recommended.',
                  style: TextStyle(fontSize: 25, fontFamily: 'Kanit')),
            ])));
  }
}
