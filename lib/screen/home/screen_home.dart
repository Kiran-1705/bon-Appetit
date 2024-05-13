import 'dart:async';
import 'package:bon_appetit/screen/home/screen_favorites.dart';
import 'package:bon_appetit/screen/home/screen_profile.dart';
import 'package:bon_appetit/screen/home/screen_recipes.dart';
import 'package:bon_appetit/widget/HomeWidgets/home_browsebutton.dart';
import 'package:bon_appetit/widget/HomeWidgets/home_imagepath.dart';
import 'package:bon_appetit/widget/HomeWidgets/home_recipe.dart';
import 'package:bon_appetit/widget/HomeWidgets/home_recommended.dart';
import 'package:bon_appetit/widget/HomeWidgets/aloochat.dart';
import 'package:bon_appetit/widget/Components/bottom_bar.dart';
import 'package:bon_appetit/widget/HomeWidgets/cb.dart';
import 'package:bon_appetit/widget/HomeWidgets/cfriedrice.dart';
import 'package:bon_appetit/widget/HomeWidgets/classicmargarita.dart';
import 'package:bon_appetit/widget/HomeWidgets/recipe_day_box.dart';
import 'package:bon_appetit/widget/HomeWidgets/recommended_box.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const ScreenHome(),
    const ScreenRecipes(),
    const ScreenFavorites(),
    const ScreenProfile()
  ];
  late Timer _timer;
  final List<Recipe> _recipes = [
    Recipe(
        title: 'Classic Margarita',
        description:
            'The classic margarita is a refreshing and simple cocktail, perfect for any occasion',
        imagePaths: ImagePaths.classicMargarita),
    Recipe(
        title: 'Aloo Chat',
        description:
            'Delicious and spicy Aloo Chat, a popular street food in India',
        imagePaths: ImagePaths.alooChat)
  ];
  final List<Recipe> _recommendations = [
    Recipe(
        title: 'Chicken Briyani',
        description:
            'A fragrant symphony of spices and tender chicken, nestled in a bed of perfectly cooked basmati rice, creating a culinary masterpiece.',
        imagePaths: ImagePaths.cb),
    Recipe(
        title: 'Chicken Fried Rice',
        description:
            'Delicious and flavorful Chicken Fried Rice, a quick and tasty dish to satisfy your cravings',
        imagePaths: ImagePaths.cfriedRice)
  ];
  int _currentRecipeIndex = 0;
  int _currentRecommendedIndex = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(hours: 24), (timer) {
      setState(() {
        _currentRecipeIndex = (_currentRecipeIndex + 1) % _recipes.length;
        _currentRecommendedIndex =
            (_currentRecommendedIndex + 1) % _recommendations.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentRecipe = _recipes[_currentRecipeIndex];
    var currentRecommendation = _recommendations[_currentRecommendedIndex];
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
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          const Padding(
              padding: EdgeInsets.only(left: 18, right: 18, top: 10),
              child: Row(children: [
                Text('bon Appetit.',
                    style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Righteous')),
              ])),
          const SizedBox(height: 25),
          RecipeCard(
              title: currentRecipe.title,
              description: currentRecipe.description,
              imagePaths: currentRecipe.imagePaths,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => _currentRecipeIndex == 0
                            ? ScreenClassic()
                            : ScreenAlooChat()));
              }),
          const SizedBox(height: 20),
          RecommendedText(),
          RecommendedBox(
              title: currentRecommendation.title,
              description: currentRecommendation.description,
              imagePaths: currentRecommendation.imagePaths,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => _currentRecommendedIndex == 0
                            ? ScreenCB()
                            : ScreenCFriedRice()));
              }),
          const SizedBox(height: 15),
          BrowseButton(
              buttonText: 'Browse More Recipes',
              destination: const ScreenRecipes()),
          const SizedBox(height: 15),
        ]))));
  }
}
