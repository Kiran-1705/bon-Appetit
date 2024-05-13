import 'package:bon_appetit/widget/DisplayWidgets/display_accept.dart';
import 'package:bon_appetit/widget/RecipeWidgets/recipe_box.dart';
import 'package:flutter/material.dart';
import 'package:bon_appetit/database/model/accept_model.dart';

class RecipeItemsBuilder {
  static Widget buildRecipeItems(List<AcceptModel> acceptedRecipes) {
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
