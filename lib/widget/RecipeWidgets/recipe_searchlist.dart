import 'dart:io';
import 'package:bon_appetit/widget/DisplayWidgets/display_accept.dart';
import 'package:flutter/material.dart';
import 'package:bon_appetit/database/model/accept_model.dart';

class RecipeListView extends StatelessWidget {
  final List<AcceptModel> filteredRecipes;
  final TextEditingController searchController;

  const RecipeListView({
    Key? key,
    required this.filteredRecipes,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return filteredRecipes.isEmpty
        ? Center(
            child: Text(
                'No recipes available for "${searchController.text}" yet.',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'RalewayVariableFont')))
        : ListView.builder(
            itemCount: filteredRecipes.length,
            itemBuilder: (BuildContext context, int index) {
              final AcceptModel acceptModel = filteredRecipes[index];
              return ListTile(
                  leading: ClipOval(
                      child: Image(
                          image: FileImage(File(acceptModel.imagePath[1])),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover)),
                  title: Text(acceptModel.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: 'Kanit')),
                  subtitle: Text(acceptModel.category,
                      style:
                          const TextStyle(fontSize: 15, fontFamily: 'Kanit')),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ScreenOut(recipe: acceptModel)));
                  });
            },
          );
  }
}
