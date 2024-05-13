import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:bon_appetit/screen/home/screen_favorites.dart';
import 'package:bon_appetit/screen/home/screen_home.dart';
import 'package:bon_appetit/screen/home/screen_profile.dart';
import 'package:bon_appetit/widget/RecipeWidgets/recipe_iconbutton.dart';
import 'package:bon_appetit/widget/RecipeWidgets/recipe_itembuilder.dart';
import 'package:bon_appetit/widget/Components/bottom_bar.dart';
import 'package:flutter/material.dart';

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
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text('R e c i p e s',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: 'Righteous'))),
                              const IconButtons(),
                            ]),
                        const SizedBox(height: 15),
                        _dataLoaded
                            ? RecipeItemsBuilder.buildRecipeItems(
                                acceptedRecipes)
                            : const Center(
                                child: Text('No recipes available.',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'RalewayVariableFont',
                                        color: Colors.white))),
                      ]))),
        ));
  }
}
