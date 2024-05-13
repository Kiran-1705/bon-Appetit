import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bon_appetit/screen/home/screen_profile.dart'; // Ensure paths are correct

class UserProfileWidget extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String imagePath;

  const UserProfileWidget({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return name.isNotEmpty
        ? Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            CircleAvatar(
              minRadius: 55,
              backgroundColor: Colors.white,
              backgroundImage:
                  imagePath.isNotEmpty ? FileImage(File(imagePath)) : null,
              child: imagePath.isEmpty
                  ? const Icon(Icons.person, color: Colors.black, size: 55)
                  : null,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontFamily: 'Righteous')),
              const SizedBox(height: 5),
              Text(email,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Righteous',
                      fontSize: 17)),
              const SizedBox(height: 5),
              Text(phone,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Righteous',
                      fontSize: 17)),
            ]),
          ])
        : Column(children: [
            const Text('Please login to continue',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Righteous')),
            const SizedBox(height: 7),
            Text('------OR------',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Righteous')),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScreenProfile()));
                },
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'Refresh',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RalewayVariableFont',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
          ]);
  }
}
