import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:bon_appetit/database/model/recipe_model.dart';
import 'package:bon_appetit/widget/accepted.dart';
import 'package:bon_appetit/widget/pending.dart';
import 'package:bon_appetit/widget/rejected.dart';
import 'package:bon_appetit/widget/tab_button.dart';
import 'package:flutter/material.dart';

class ScreenAdminRecipes extends StatefulWidget {
  const ScreenAdminRecipes({Key? key}) : super(key: key);

  @override
  State<ScreenAdminRecipes> createState() => _ScreenAdminRecipesState();
}

class _ScreenAdminRecipesState extends State<ScreenAdminRecipes> {
  int _selectedTabIndex = 0;
  late List<RecipeModel> acceptedRecipes = [];

  @override
  void initState() {
    super.initState();
    fetchAcceptedRecipes();
  }

  Future<void> fetchAcceptedRecipes() async {
    List<AcceptModel> fetchedRecipes = await getAllAccept();
    setState(() {
      acceptedRecipes = fetchedRecipes.cast<RecipeModel>();
    });
  }

  AcceptModel convertToAcceptModel(RecipeModel recipeModel) {
    return AcceptModel(
      title: recipeModel.title,
      category: recipeModel.category,
      url: recipeModel.url,
      ingredients: recipeModel.ingredients,
      imagePath: recipeModel.imagePath,
      steps: recipeModel.steps,
      tips: recipeModel.tips,
      uploadedBy: recipeModel.uploadedBy,
    );
  }

  List<AcceptModel> convertListToAcceptModel(List<RecipeModel> recipeList) {
    return recipeList.map((recipe) {
      return convertToAcceptModel(recipe);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'R E C I P E S',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w700,
            fontFamily: 'RalewayVariableFont',
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              TabButtons(
                _selectedTabIndex,
                0,
                'Pending',
                _onTabTapped,
              ),
              TabButtons(
                _selectedTabIndex,
                1,
                'Rejected',
                _onTabTapped,
              ),
              TabButtons(
                _selectedTabIndex,
                2,
                'Accepted',
                _onTabTapped,
              ),
            ],
          ),
          Expanded(
            child: _buildTabScreens(_selectedTabIndex),
          ),
        ],
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  Widget _buildTabScreens(int index) {
    switch (index) {
      case 0:
        return const ScreenPendingRecipes();
      case 1:
        return const ScreenRejectedRecipes();
      case 2:
        return const AcceptedRecipes();
      default:
        return Container();
    }
  }
}
