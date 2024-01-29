import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:bon_appetit/widget/recipe_day_box.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  Box<AcceptModel>? acceptedBox;
  List<bool> selectedStates = [];

  @override
  void initState() {
    super.initState();
    openAcceptedBox();
  }

  Future<void> openAcceptedBox() async {
    acceptedBox = await Hive.openBox<AcceptModel>('accept_db');
    selectedStates = List.generate(acceptedBox!.length, (index) => false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Box<AcceptModel>>(
        valueListenable: Hive.box<AcceptModel>('accept_db').listenable(),
        builder: (context, box, _) {
          final acceptedRecipes = box.values.toList().cast<AcceptModel>();

          final filteredRecipes = acceptedRecipes
              .where((recipe) => [
                    'Snack',
                    'Cocktail',
                    'Dessert',
                    'Salad',
                    'Soup'
                  ].contains(recipe.category))
              .toList();

          if (filteredRecipes.isEmpty) {
            return const Center(
              child: Text(
                'No accepted recipes available.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: filteredRecipes.length,
            itemBuilder: (BuildContext context, int index) {
              final acceptModel = filteredRecipes[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text((index + 1).toString()),
                ),
                title: Text(
                  acceptModel.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: 'Kanit',
                  ),
                ),
                subtitle: Text(
                  acceptModel.category,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Kanit',
                  ),
                ),
                trailing: Checkbox(
                  shape: const CircleBorder(),
                  value: selectedStates[index],
                  onChanged: (value) {
                    setState(() {
                      selectedStates[index] = value!;
                    });
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeOfDay(
                        acceptModel: acceptModel,
                        isSelected: selectedStates[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
