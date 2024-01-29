import 'package:bon_appetit/screen/home/screen_favorites.dart';
import 'package:bon_appetit/screen/home/screen_home.dart';
import 'package:bon_appetit/screen/home/screen_profile.dart';
import 'package:bon_appetit/widget/display_accept.dart';
import 'package:bon_appetit/widget/recipe_box.dart';
import 'package:flutter/material.dart';
import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:bon_appetit/screen/home/screen_search.dart';
import 'package:bon_appetit/widget/bottom_bar.dart';
import 'package:bon_appetit/database/db_function.dart';

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
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    loadAcceptedRecipes();
  }

  Future<void> loadAcceptedRecipes() async {
    acceptedRecipes = await getAllAccept();
    setState(() {
      _dataLoaded = true;
    });
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => _screens[index]));
              });
            }),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('R e c i p e s',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'Righteous')),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ScreenSearch()));
                                },
                                icon: const Icon(Icons.search,
                                    size: 33, color: Colors.white))
                          ]),
                      const SizedBox(height: 15),
                      _dataLoaded
                          ? _buildRecipeItems()
                          : const Center(
                              child: Text('No recipes available.',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'RalewayVariableFont'))),
                    ])))));
  }

  Widget _buildRecipeItems() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.7),
        itemCount: acceptedRecipes.length,
        itemBuilder: (BuildContext context, int index) {
          final AcceptModel recipe = acceptedRecipes[index];
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScreenOut(recipe: recipe)));
              },
              child: RecipeItem(
                  acceptModel: recipe,
                  title: recipe.title,
                  subtitle: recipe.category,
                  imagePath: recipe.imagePath));
        });
  }
}
