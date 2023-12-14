import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:bon_appetit/widget/bottom_bar.dart';
import 'package:bon_appetit/widget/cb.dart';
import 'package:bon_appetit/widget/recipe_box.dart';
import 'package:flutter/material.dart';
import 'screen_home.dart';
import 'screen_favorites.dart';
import 'screen_profile.dart';

class ScreenRecipes extends StatefulWidget {
  const ScreenRecipes({Key? key});

  @override
  State<ScreenRecipes> createState() => _ScreenRecipesState();
}

class _ScreenRecipesState extends State<ScreenRecipes> {
  int _currentIndex = 1;
  final List<Widget> _screens = [
    const ScreenHome(),
    const ScreenRecipes(),
    const ScreenFavorites(),
    const ScreenProfile(),
  ];
  late List<AcceptModel> acceptedRecipes;

  @override
  void initState() {
    super.initState();
    // loadAcceptedRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'R e c i p e s',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search,
                          color: Colors.white, size: 33),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 750,
                  width: 370,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          // RecipeItem 1
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScreenCB(),
                                ),
                              );
                            },
                            child: const RecipeItem(
                              title: 'Chicken Biryani',
                              subtitle:
                                  'Fragrant basmati, spiced chicken, aromatic layers.',
                              imagePaths: [
                                'lib/assets/cb1.jpg',
                                'lib/assets/cb2.jpg',
                                'lib/assets/cb3.jpeg'
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // RecipeItem 2
                          const RecipeItem(
                            title: 'Chicken Fried Rice',
                            subtitle: 'Stir-fried rice with seasoned chicken.',
                            imagePaths: [
                              // 'lib/assets/friedrice1.jpg',
                              // 'lib/assets/friedrice2.png',
                              // 'lib/assets/friedrice3.jpeg'
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                      const Column(
                        children: [
                          // RecipeItem 4
                          SizedBox(height: 30),
                          RecipeItem(
                            title: 'Masala Dosa',
                            subtitle:
                                'Thin, crispy Indian crepe with spiced filling.',
                            imagePaths: [
                              // 'lib/assets/masaladosa1.webp',
                              // 'lib/assets/masaladosa2.jpg',
                              // 'lib/assets/masaladosa3.webp'
                            ],
                          ),
                          SizedBox(height: 20),
                          // RecipeItem 5
                          RecipeItem(
                            title: 'Malabar Fish Curry',
                            subtitle:
                                'Spicy coconut-based curry with fresh fish.',
                            imagePaths: [
                              // 'lib/assets/fishcurry1.jpg',
                              // 'lib/assets/fishcurry2.jpg',
                              // 'lib/assets/fishcurry3.jpg'
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRecipeItems() {
    return acceptedRecipes.map((recipe) {
      return GestureDetector(
        onTap: () {},
        child: RecipeItem(
          title: recipe.title,
          subtitle: recipe.category,
          imagePaths: recipe.imagePath,
        ),
      );
    }).toList();
  }
}
