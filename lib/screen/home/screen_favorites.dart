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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'F a v o r i t e s',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      size: 33,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Recipe Cards
            const FavoriteCard(
              title: 'Delicious Recipe 1',
              subtitle: 'Amazing ingredients and flavors',
            ),
            const SizedBox(height: 20),
            const FavoriteCard(
              title: 'Tasty Recipe 2',
              subtitle: 'Unique and flavorful combination',
            ),
            const SizedBox(height: 20),
            const FavoriteCard(
              title: 'Fantastic Recipe 3',
              subtitle: 'Exquisite taste and presentation',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
