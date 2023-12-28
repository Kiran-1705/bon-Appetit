import 'package:bon_appetit/screen/admin/screen_adrecipes.dart';
import 'package:bon_appetit/screen/admin/screen_adusers.dart';
import 'package:flutter/material.dart';

class ScreenAdminHome extends StatefulWidget {
  const ScreenAdminHome({super.key});

  @override
  State<ScreenAdminHome> createState() => _ScreenAdminHomeState();
}

class _ScreenAdminHomeState extends State<ScreenAdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'A D M I N',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontFamily: 'RalewayVariableFont',
          ),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ScreenAdminUsers()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  children: [
                    SizedBox(width: 30),
                    CircleAvatar(radius: 35, child: Icon(Icons.person)),
                    SizedBox(width: 30),
                    Text(
                      'U S E R S',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'RalewayVariableFont',
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ScreenAdminRecipes()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  children: [
                    SizedBox(width: 30),
                    CircleAvatar(radius: 35, child: Icon(Icons.receipt)),
                    SizedBox(width: 30),
                    Text(
                      'R E C I P E S',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'RalewayVariableFont',
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
