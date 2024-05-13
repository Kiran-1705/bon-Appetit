import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:bon_appetit/database/model/favorite_model.dart';
import 'package:bon_appetit/screen/home/screen_home.dart';
import 'package:bon_appetit/screen/home/screen_recipes.dart';
import 'package:bon_appetit/screen/home/screen_profile.dart';
import 'package:bon_appetit/widget/FavoriteWidgets/favorite_list.dart';
import 'package:bon_appetit/widget/Components/bottom_bar.dart';

class ScreenFavorites extends StatefulWidget {
  const ScreenFavorites({Key? key}) : super(key: key);

  @override
  State<ScreenFavorites> createState() => _ScreenFavoritesState();
}

class _ScreenFavoritesState extends State<ScreenFavorites> {
  int _currentIndex = 2;
  final List<Widget> _screens = [
    const ScreenHome(),
    const ScreenRecipes(),
    const ScreenFavorites(),
    const ScreenProfile()
  ];

  Future<Box<FavoriteModel>>? favoriteBoxFuture;

  @override
  void initState() {
    super.initState();
    favoriteBoxFuture = openFavoriteBox();
  }

  Future<Box<FavoriteModel>> openFavoriteBox() async {
    return await Hive.openBox<FavoriteModel>('favorite_db');
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
          },
        ),
        body: FutureBuilder<Box<FavoriteModel>>(
          future: favoriteBoxFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                    child:
                        Text("Error opening favorite box: ${snapshot.error}"));
              } else {
                return SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text('F a v o r i t e s',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'Righteous')),
                      ),
                      const SizedBox(height: 10),
                      const Expanded(child: FavoritesList()),
                    ],
                  ),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
