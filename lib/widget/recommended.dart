import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:bon_appetit/widget/display_accept.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RecommendedRecipe extends StatefulWidget {
  const RecommendedRecipe({super.key});

  @override
  State<RecommendedRecipe> createState() => _RecommendedRecipeState();
}

class _RecommendedRecipeState extends State<RecommendedRecipe> {
  Box<AcceptModel>? acceptedBox;

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
      body: ValueListenableBuilder<Box<AcceptModel>>(
        valueListenable: Hive.box<AcceptModel>('accept_db').listenable(),
        builder: (context, box, _) {
          final acceptedRecipes = box.values.toList().cast<AcceptModel>();

          if (acceptedRecipes.isEmpty) {
            return const Center(
              child: Text(
                'No accepted recipes available.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: acceptedRecipes.length,
            itemBuilder: (BuildContext context, int index) {
              final acceptModel = acceptedRecipes[index];
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
                  shape: CircleBorder(),
                  value: false,
                  onChanged: null,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScreenOut(
                        recipe: acceptModel,
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
