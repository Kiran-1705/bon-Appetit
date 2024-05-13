import 'package:bon_appetit/widget/DisplayWidgets/display_favorite.dart';
import 'package:bon_appetit/widget/FavoriteWidgets/favorite_box.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bon_appetit/database/model/favorite_model.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<FavoriteModel>>(
      valueListenable: Hive.box<FavoriteModel>('favorite_db').listenable(),
      builder: (context, box, _) {
        final List<FavoriteModel> favoriteRecipes = box.values.toList();
        if (favoriteRecipes.isEmpty) {
          return const Center(
            child: Text('No favorited recipes yet.',
                style: TextStyle(fontSize: 25, fontFamily: 'Righteous')),
          );
        }
        return ListView.builder(
          itemCount: favoriteRecipes.length,
          itemBuilder: (BuildContext context, int index) {
            final FavoriteModel recipe = favoriteRecipes[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenFavoriteOut(recipe: recipe)),
                );
              },
              child: FavoriteCard(
                title: recipe.title,
                subtitle: recipe.tips,
                imagePath: recipe.imagePath,
                favoriteModel: recipe,
              ),
            );
          },
        );
      },
    );
  }
}
