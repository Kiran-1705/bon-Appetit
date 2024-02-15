import 'dart:async';
import 'package:bon_appetit/screen/home/screen_favorites.dart';
import 'package:bon_appetit/screen/home/screen_profile.dart';
import 'package:bon_appetit/screen/home/screen_recipes.dart';
import 'package:bon_appetit/widget/aloochat.dart';
import 'package:bon_appetit/widget/bottom_bar.dart';
import 'package:bon_appetit/widget/cb.dart';
import 'package:bon_appetit/widget/cfriedrice.dart';
import 'package:bon_appetit/widget/classicmargarita.dart';
import 'package:bon_appetit/widget/recipe_day_box.dart';
import 'package:bon_appetit/widget/recommended_box.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _currentIndex = 0;
  List<String> alooimagePath = [
    'lib/assets/aloochat1.png',
    'lib/assets/aloochat2.jpg',
    'lib/assets/aloochat3.jpg'
  ];
  List<String> classicmargarita = [
    'lib/assets/classicmargarita1.jpg',
    'lib/assets/classicmargarita2.jpg',
    'lib/assets/classicmargarita3.jpg'
  ];
  List<String> cbimagepath = [
    'lib/assets/cb1.jpg',
    'lib/assets/cb2.jpg',
    'lib/assets/cb3.jpeg'
  ];
  List<String> cfriedrice = [
    'lib/assets/Cfriedrice.jpg',
    'lib/assets/Cfriedrice2.jpg',
    'lib/assets/Cfriedrice3.jpg'
  ];
  final List<Widget> _screens = [
    const ScreenHome(),
    const ScreenRecipes(),
    const ScreenFavorites(),
    const ScreenProfile()
  ];
  late Timer _timer;
  int _currentRecipeIndex = 0;
  int _currentRecommendedIndex = 0;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(hours: 24), (timer) {
      setState(() {
        _currentRecipeIndex = (_currentRecipeIndex + 1) % 2;
        _currentRecommendedIndex = (_currentRecommendedIndex + 1) % 2;
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
    String currentRecipeTitle =
        _currentRecipeIndex == 0 ? 'Classic Margarita' : 'Aloo Chat';
    String currentRecipeDescription = _currentRecipeIndex == 0
        ? 'The classic margarita is a refreshing and simple cocktail, perfect for any occasion'
        : 'Delicious and spicy Aloo Chat, a popular street food in India';
    List<String> currentRecipeImages =
        _currentRecipeIndex == 0 ? classicmargarita : alooimagePath;
    String currentRecommendedTitle = _currentRecommendedIndex == 0
        ? 'Chicken Briyani'
        : 'Chicken Fried Rice';
    String currentRecommendedDescription = _currentRecommendedIndex == 0
        ? 'A fragrant symphony of spices and tender chicken, nestled in a bed of perfectly cooked basmati rice, creating a culinary masterpiece.'
        : 'Delicious and flavorful Chicken Fried Rice, a quick and tasty dish to satisfy your cravings';
    List<String> currentRecommendedImages =
        _currentRecommendedIndex == 0 ? cbimagepath : cfriedrice;
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
              title: currentRecipeTitle,
              description: currentRecipeDescription,
              imagePaths: currentRecipeImages,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => _currentRecipeIndex == 0
                            ? ScreenClassic()
                            : ScreenAlooChat()));
              }),
          const SizedBox(height: 20),
          Container(
              height: 90,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('For You',
                            style: TextStyle(
                                fontSize: 29,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit')),
                        Text('recommended.',
                            style:
                                TextStyle(fontSize: 25, fontFamily: 'Kanit')),
                      ]))),
          RecommendedBox(
              title: currentRecommendedTitle,
              description: currentRecommendedDescription,
              imagePaths: currentRecommendedImages,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => _currentRecommendedIndex == 0
                            ? ScreenCB()
                            : ScreenCFriedRice()));
              }),
          const SizedBox(height: 15),
          SizedBox(
              width: 345,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenRecipes()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: const BorderSide(color: Colors.black),
                      ),
                      minimumSize: const Size(double.infinity, 50)),
                  child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Browse More Recipes',
                          style: TextStyle(
                              fontSize: 23,
                              fontFamily: 'RalewayVariableFont',
                              fontWeight: FontWeight.w700))))),
          const SizedBox(height: 15),
        ]))));
  }
}
