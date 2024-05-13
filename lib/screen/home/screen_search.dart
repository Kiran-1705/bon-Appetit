import 'package:bon_appetit/widget/RecipeWidgets/recipe_searchlist.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../database/model/accept_model.dart';

class ScreenSearchRecipe extends StatefulWidget {
  const ScreenSearchRecipe({super.key});

  @override
  State<ScreenSearchRecipe> createState() => _ScreenSearchRecipeState();
}

class _ScreenSearchRecipeState extends State<ScreenSearchRecipe> {
  final TextEditingController searchController = TextEditingController();
  Box<AcceptModel>? acceptedBox;
  List<AcceptModel> filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    openAcceptedBox();
  }

  Future<void> openAcceptedBox() async {
    acceptedBox = await Hive.openBox<AcceptModel>('accept_db');
    filterRecipes();
  }

  void filterRecipes() {
    if (acceptedBox != null) {
      if (searchController.text.isEmpty) {
        filteredRecipes = acceptedBox!.values.toList();
      } else {
        filteredRecipes = acceptedBox!.values
            .where((recipe) => recipe.title
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
            .toList();
      }
    } else {
      filteredRecipes = [];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('S e a r c h',
              style: TextStyle(fontSize: 25, fontFamily: 'Righteous')),
          centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: "Search Recipes",
                  labelStyle: const TextStyle(
                      fontFamily: 'RalewayVariableFont',
                      fontWeight: FontWeight.w700),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            filterRecipes();
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  filterRecipes();
                },
              ),
            ),
            Expanded(
              child: RecipeListView(
                filteredRecipes: filteredRecipes,
                searchController: searchController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
