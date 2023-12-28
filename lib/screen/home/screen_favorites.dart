import 'package:bon_appetit/screen/home/screen_home.dart';
import 'package:bon_appetit/screen/home/screen_profile.dart';
import 'package:bon_appetit/screen/home/screen_recipes.dart';
import 'package:bon_appetit/widget/bottom_bar.dart';
import 'package:bon_appetit/widget/favorite_box.dart';
import 'package:flutter/material.dart';

class ScreenFavorites extends StatefulWidget {
  const ScreenFavorites({Key? key});

  @override
  State<ScreenFavorites> createState() => _ScreenFavoritesState();
}

class _ScreenFavoritesState extends State<ScreenFavorites> {
  int _currentIndex = 2;
  final List<Widget> _screens = [
    const ScreenHome(),
    const ScreenRecipes(),
    const ScreenFavorites(),
    const ScreenProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBarWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => _screens[index]),
            );
          });
        },
      ),
      body: const SafeArea(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'F a v o r i t e s',
                  style: TextStyle(fontSize: 25, fontFamily: 'Righteous'),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Recipe Cards
          FavoriteCard(
            title: 'Delicious Recipe 1',
            subtitle: 'Amazing ingredients and flavors',
          ),
          SizedBox(height: 20),
          FavoriteCard(
            title: 'Tasty Recipe 2',
            subtitle: 'Unique and flavorful combination',
          ),
          SizedBox(height: 20),
          FavoriteCard(
            title: 'Fantastic Recipe 3',
            subtitle: 'Exquisite taste and presentation',
          ),
          SizedBox(height: 20),
        ]),
      ),
    );
  }
}
