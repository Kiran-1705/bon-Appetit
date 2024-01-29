import 'package:bon_appetit/database/model/favorite_model.dart';
import 'package:bon_appetit/screen/home/screen_home.dart';
import 'package:bon_appetit/screen/home/screen_profile.dart';
import 'package:bon_appetit/screen/home/screen_recipes.dart';
import 'package:bon_appetit/widget/bottom_bar.dart';
import 'package:bon_appetit/widget/display_favorite.dart';
import 'package:bon_appetit/widget/favorite_box.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScreenFavorites extends StatefulWidget {
  const ScreenFavorites({Key? key});

  @override
  State<ScreenFavorites> createState() => _ScreenFavoritesState();
}

class _ScreenFavoritesState extends State<ScreenFavorites> {
  late Box<FavoriteModel> favoriteBox;

  int _currentIndex = 2;
  final List<Widget> _screens = [
    const ScreenHome(),
    const ScreenRecipes(),
    const ScreenFavorites(),
    const ScreenProfile(),
  ];

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    final box = await Hive.openBox<FavoriteModel>('favorite_db');
    setState(() {
      favoriteBox = box;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBarWidget(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => _screens[index]));
              });
            }),
        appBar: AppBar(
            title: const Text('F a v o r i t e s',
                style: TextStyle(fontSize: 25, fontFamily: 'Righteous')),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.search, size: 30))
            ]),
        body: ValueListenableBuilder<Box<FavoriteModel>>(
            valueListenable:
                Hive.box<FavoriteModel>('favorite_db').listenable(),
            builder: (context, box, _) {
              final List<FavoriteModel> favoriteRecipes = box.values.toList();

              return ListView.builder(
                  itemCount: favoriteRecipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final FavoriteModel recipe = favoriteRecipes[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ScreenFavoriteOut(recipe: recipe)));
                        },
                        child: FavoriteCard(
                            title: recipe.title,
                            subtitle: recipe.tips,
                            imagePath: recipe.imagePath,
                            favoriteModel: recipe));
                  });
            }));
  }
}
