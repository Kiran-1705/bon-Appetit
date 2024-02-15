import 'package:bon_appetit/screen/home/screen_home.dart';
import 'package:flutter/material.dart';

class ScreenStart extends StatelessWidget {
  const ScreenStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
          Container(
              height: 500,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('lib/assets/start.jpg'),
                      fit: BoxFit.cover))),
          const Text('All the recipes on \n  Your fingertips',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Righteous')),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenHome()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      minimumSize: const Size(double.infinity, 50)),
                  child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Get Started',
                          style: TextStyle(
                              fontSize: 33,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Righteous'))))),
        ])));
  }
}
