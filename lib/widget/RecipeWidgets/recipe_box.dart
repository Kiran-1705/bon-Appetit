import 'dart:io';
import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:bon_appetit/database/model/favorite_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share/share.dart';

class RecipeItem extends StatefulWidget {
  final AcceptModel acceptModel;
  const RecipeItem({
    required this.acceptModel,
    Key? key,
    required String title,
    required String subtitle,
    String? uploadedBy,
    required List<String> imagePath,
  }) : super(key: key);

  @override
  State<RecipeItem> createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    bool exists =
        await checkIfRecipeExistsInFavorites(widget.acceptModel.title);
    setState(() {
      isFavorite = exists;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: screenSize.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: screenSize.height * 0.17,
                width: screenSize.width * 0.35,
                child: CarouselSlider(
                  items: widget.acceptModel.imagePath.map((imagePath) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: FileImage(File(imagePath)),
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3, left: 8),
              child: Text(
                widget.acceptModel.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  fontFamily: 'Kanit',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                widget.acceptModel.category,
                style: const TextStyle(fontFamily: 'Kanit', fontSize: 15),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    setState(() {
                      if (isFavorite) {
                        deleteFromFavorites(widget.acceptModel.title);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Recipe removed from favorites',
                              style:
                                  TextStyle(fontFamily: 'Kanit', fontSize: 15),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        isFavorite = false;
                      } else {
                        addAcceptedRecipeToFavorites(widget.acceptModel);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Recipe added to favorites',
                              style:
                                  TextStyle(fontFamily: 'Kanit', fontSize: 15),
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        isFavorite = true;
                      }
                    });
                  },
                  icon: Icon(
                    Icons.favorite,
                    size: 34,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String recipeTitle = widget.acceptModel.title;
                    String deepLink = generateRecipeDeepLink(recipeTitle);
                    String shareMessage =
                        'Check out this delicious recipe: $recipeTitle\n$deepLink';
                    Share.share(shareMessage);
                  },
                  icon: const Icon(
                    Icons.share,
                    size: 34,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

void deleteFromFavorites(String title) async {
  final favoriteBox = await Hive.openBox<FavoriteModel>('favorite_db');
  int index = favoriteBox.values
      .toList()
      .indexWhere((element) => element.title == title);
  if (index != -1) {
    await favoriteBox.deleteAt(index);
  }
}

Future<bool> checkIfRecipeExistsInFavorites(String title) async {
  final favoriteBox = await Hive.openBox<FavoriteModel>('favorite_db');
  return favoriteBox.values.any((recipe) => recipe.title == title);
}

String generateRecipeDeepLink(String recipeTitle) {
  String encodedTitle = Uri.encodeComponent(recipeTitle);
  return 'yourapp://recipe/$encodedTitle';
}
