import 'dart:io';

import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:bon_appetit/widget/DisplayWidgets/display_accept.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ScreenSort extends StatefulWidget {
  const ScreenSort({super.key});

  @override
  State<ScreenSort> createState() => _ScreenSortState();
}

class _ScreenSortState extends State<ScreenSort> {
  String? tappedCategory;
  bool showingRecipes = false;
  Box<AcceptModel>? acceptedBox;
  List<AcceptModel>? categoryRecipes;

  @override
  void initState() {
    super.initState();
    openAcceptedBox();
  }

  Future<void> openAcceptedBox() async {
    acceptedBox = await Hive.openBox<AcceptModel>('accept_db');
    setState(() {});
  }

  void showRecipesForCategory(String category) {
    if (acceptedBox != null) {
      categoryRecipes = acceptedBox!.values
          .where((recipe) => recipe.category == category)
          .toList();
      tappedCategory = category;
      showingRecipes = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('S o r t',
            style: TextStyle(fontSize: 25, fontFamily: 'Righteous')),
        centerTitle: true,
      ),
      body: showingRecipes ? _buildListView() : _buildCategoryGridView(),
    );
  }

  Widget _buildCategoryGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      children: [
        _buildImageWithText(
            imagePath: "lib/assets/search1.png", text: 'Breakfast'),
        _buildImageWithText(imagePath: "lib/assets/search2.jpg", text: 'Lunch'),
        _buildImageWithText(
            imagePath: "lib/assets/search3.png", text: 'Dinner'),
        _buildImageWithText(
            imagePath: "lib/assets/cocktails.jpg", text: 'Cocktail'),
        _buildImageWithText(imagePath: "lib/assets/search4.png", text: 'Snack'),
        _buildImageWithText(
            imagePath: "lib/assets/diserts.jpg", text: 'Dessert'),
        _buildImageWithText(imagePath: "lib/assets/curry.png", text: 'Curry'),
        _buildImageWithText(imagePath: "lib/assets/salad.png", text: 'Salad'),
        _buildImageWithText(imagePath: "lib/assets/soup.png", text: 'Soup'),
      ],
    );
  }

  Widget _buildImageWithText(
      {required String imagePath, required String text}) {
    return GestureDetector(
      onTap: () => showRecipesForCategory(text),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        height: 120,
        width: 100,
        child: Column(
          children: [
            const SizedBox(height: 5),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(imagePath, fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(text,
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(fontSize: 16, fontFamily: 'Righteous')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    if (categoryRecipes == null || categoryRecipes!.isEmpty) {
      return Center(
        child: Text('No recipes available for $tappedCategory yet.',
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'RalewayVariableFont')),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: categoryRecipes!.length,
          itemBuilder: (BuildContext context, int index) {
            final AcceptModel acceptModel = categoryRecipes![index];
            return ListTile(
              leading: ClipOval(
                child: Image(
                    image: FileImage(File(acceptModel.imagePath[2])),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover),
              ),
              title: Text(acceptModel.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Kanit')),
              subtitle: Text(acceptModel.category,
                  style: const TextStyle(fontSize: 15, fontFamily: 'Kanit')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenOut(recipe: acceptModel)),
                );
              },
            );
          },
        ),
      );
    }
  }
}
