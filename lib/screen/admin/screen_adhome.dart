import 'package:bon_appetit/screen/admin/screen_adrecipes.dart';
import 'package:bon_appetit/screen/admin/screen_adusers.dart';
import 'package:bon_appetit/screen/screen_sign.dart';
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
      body: Column(
        children: [
          SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.black,
            child: Text(
              'A D M I N',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontFamily: 'RalewayVariableFont',
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenAdminUsers(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
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
                  builder: (context) => const ScreenAdminRecipes(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: TextButton(
          onPressed: confirmLogout,
          child: const Text(
            ' Logout ',
            style: TextStyle(
              fontSize: 21,
              fontFamily: 'Kanit',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> confirmLogout() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Logout',
                  style: TextStyle(fontFamily: 'Kanit', fontSize: 22)),
              content: const Text('Are you sure you want to logout?',
                  style: TextStyle(fontFamily: 'Kanit', fontSize: 18)),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No',
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w400,
                            fontSize: 20))),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _logout();
                    },
                    child: const Text('Yes',
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w400,
                            fontSize: 20))),
              ]);
        });
  }

  void _logout() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const ScreenSign()));
  }
}
