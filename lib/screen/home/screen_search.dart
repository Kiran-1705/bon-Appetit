import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:bon_appetit/widget/display_accept.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({Key? key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final TextEditingController _searchController = TextEditingController();
  Box<AcceptModel>? acceptedBox;
  String? tappedCategory;

  @override
  void initState() {
    super.initState();
    openAcceptedBox();
  }

  Future<void> openAcceptedBox() async {
    acceptedBox = await Hive.openBox<AcceptModel>('accept_db');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('S e a r c h',
                style: TextStyle(fontSize: 25, fontFamily: 'Righteous')),
            centerTitle: true),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: 'Search by Ingredient/Name',
                      labelStyle: const TextStyle(
                          fontFamily: 'RalewayVariableFont',
                          fontWeight: FontWeight.w700)))),
          const SizedBox(height: 20),
          tappedCategory != null ? _buildListView() : _buildCategoryGridView(),
        ]));
  }

  Widget _buildCategoryGridView() {
    return GridView.count(shrinkWrap: true, crossAxisCount: 3, children: [
      _buildImageWithText(
          imagePath: "lib/assets/search1.png", text: 'Breakfast'),
      _buildImageWithText(imagePath: "lib/assets/search2.jpg", text: 'Lunch'),
      _buildImageWithText(imagePath: "lib/assets/search3.png", text: 'Dinner'),
      _buildImageWithText(
          imagePath: "lib/assets/cocktails.jpg", text: 'Cocktail'),
      _buildImageWithText(imagePath: "lib/assets/search4.png", text: 'Snack'),
      _buildImageWithText(imagePath: "lib/assets/diserts.jpg", text: 'Dessert'),
      _buildImageWithText(imagePath: "lib/assets/curry.png", text: 'Curry'),
      _buildImageWithText(imagePath: "lib/assets/salad.png", text: 'Salad'),
    ]);
  }

  Widget _buildImageWithText(
      {required String imagePath, required String text}) {
    return GestureDetector(
        onTap: () {
          setState(() {
            tappedCategory = text;
          });
        },
        child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            height: 120,
            width: 100,
            child: Column(children: [
              const SizedBox(height: 5),
              Expanded(
                  child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(imagePath, fit: BoxFit.fill))),
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'Righteous'))),
            ])));
  }

  Widget _buildListView() {
    final acceptedRecipes =
        Hive.box<AcceptModel>('accept_db').values.toList().cast<AcceptModel>();
    final selectedCategoryRecipes = acceptedRecipes
        .where((recipe) => recipe.category == tappedCategory!)
        .toList();

    return selectedCategoryRecipes.isEmpty
        ? Center(
            child: Text('No recipes available for $tappedCategory yet.',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'RalewayVariableFont')))
        : Expanded(
            child: ListView.builder(
                itemCount: selectedCategoryRecipes.length,
                itemBuilder: (BuildContext context, int index) {
                  final acceptModel = selectedCategoryRecipes[index];
                  return ListTile(
                      leading:
                          CircleAvatar(child: Text((index + 1).toString())),
                      title: Text(acceptModel.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontFamily: 'Kanit')),
                      subtitle: Text(acceptModel.category,
                          style: const TextStyle(
                              fontSize: 15, fontFamily: 'Kanit')),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ScreenOut(recipe: acceptModel)));
                      });
                }));
  }
}
