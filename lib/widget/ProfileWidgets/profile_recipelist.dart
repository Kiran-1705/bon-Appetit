import 'dart:io';

import 'package:bon_appetit/widget/DisplayWidgets/display_recipe.dart';
import 'package:flutter/material.dart';
import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/recipe_model.dart';
import 'package:bon_appetit/widget/AddRecipeWidgets/update_recipe.dart';

class ProfileRecipeList extends StatelessWidget {
  final String userEmailAddress;
  final ValueNotifier<List<RecipeModel>> recipeListNotifier;

  const ProfileRecipeList({
    Key? key,
    required this.userEmailAddress,
    required this.recipeListNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('My Recipes.',
              style: TextStyle(fontSize: 25, fontFamily: 'Kanit')),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: ValueListenableBuilder<List<RecipeModel>>(
            valueListenable: recipeListNotifier,
            builder: (context, recipes, _) {
              final userRecipes = recipes
                  .where((recipe) => recipe.uploadedBy == userEmailAddress)
                  .toList();
              return userRecipes.isEmpty
                  ? const Center(
                      child: Text('No recipes available',
                          style: TextStyle(fontSize: 25, fontFamily: 'Kanit')))
                  : ListView.builder(
                      itemCount: userRecipes.length,
                      itemBuilder: (BuildContext context, int index) {
                        final recipe = userRecipes[index];
                        return ListTile(
                          leading: _buildLeadingImage(recipe),
                          title: Text(
                            recipe.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontFamily: 'Kanit'),
                          ),
                          subtitle: Text(recipe.category,
                              style: const TextStyle(
                                  fontFamily: 'Kanit', fontSize: 15)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ScreenRecipeOut(recipe: recipe)));
                          },
                          trailing: _buildPopupMenu(context, recipe, index),
                        );
                      },
                    );
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildLeadingImage(RecipeModel recipe) {
    return Stack(children: [
      ClipOval(
        child: Image(
          image: FileImage(File(recipe.imagePath.first)),
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      FutureBuilder<int>(
        future: checkRecipeStatus(recipe.title),
        builder: (context, snapshot) {
          Color dotColor = Colors.grey;
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            switch (snapshot.data) {
              case 1:
                dotColor = Colors.green;
                break;
              case 0:
                dotColor = Colors.red;
                break;
              default:
                dotColor = Colors.grey;
            }
          }
          return Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotColor,
              ),
            ),
          );
        },
      ),
    ]);
  }

  Widget _buildPopupMenu(BuildContext context, RecipeModel recipe, int index) {
    // Include the index here
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (String value) async {
        if (value == 'edit') {
          int status = await checkRecipeStatus(recipe.title);
          if (status == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateRecipe(
                  recipe: recipe,
                  index: index, // Use the correct index from the itemBuilder
                ),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.black,
                  title: const Text('Update Denied',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Kanit',
                          fontSize: 20)),
                  content: const Text('Only accepted recipes can be updated.',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Kanit',
                          fontSize: 17)),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Kanit',
                              fontSize: 20)),
                    ),
                  ],
                );
              },
            );
          }
        } else if (value == 'delete') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    backgroundColor: Colors.black,
                    title: const Text('Confirmation',
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 20)),
                    content: const Text(
                        'Are you sure you want to delete this recipe?',
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 17,
                            color: Colors.white)),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.white))),
                      TextButton(
                          onPressed: () {
                            deleteRecipe(index);
                            deleteAccepted(index);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Yes',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.white))),
                    ]);
              });
        }
      },
      itemBuilder: (BuildContext context) {
        return ['Edit', 'Delete'].map((String choice) {
          return PopupMenuItem<String>(
            value: choice.toLowerCase(),
            child: Text(choice,
                style: const TextStyle(fontFamily: 'Kanit', fontSize: 15)),
          );
        }).toList();
      },
    );
  }
}
