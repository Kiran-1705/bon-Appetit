import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:bon_appetit/database/model/pending_model.dart';
import 'package:bon_appetit/database/model/reject_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScreenPendingRecipes extends StatefulWidget {
  const ScreenPendingRecipes({Key? key}) : super(key: key);

  @override
  State<ScreenPendingRecipes> createState() => _ScreenPendingRecipesState();
}

class _ScreenPendingRecipesState extends State<ScreenPendingRecipes> {
  late Box<PendingModel> pendingBox;

  @override
  void initState() {
    super.initState();
    openPendingBox();
  }

  Future<void> openPendingBox() async {
    pendingBox = await Hive.openBox<PendingModel>('pending_db');
    setState(() {});
  }

  Future<void> _handleAccept(PendingModel recipe) async {
    addAccept(AcceptModel(
      title: recipe.title,
      category: recipe.category,
      imagePath: recipe.imagePath,
      url: recipe.url,
      ingredients: recipe.ingredients,
      steps: recipe.steps,
    ));

    final pendingDB = await Hive.openBox<PendingModel>('pending_db');
    final index =
        pendingDB.values.toList().indexWhere((r) => r.title == recipe.title);

    if (index != -1) {
      await pendingDB.deleteAt(index);
    }
  }

  Future<void> _handleReject(PendingModel recipe) async {
    addRejected(RejectModel(
      title: recipe.title,
      category: recipe.category,
      imagePath: recipe.imagePath,
      url: recipe.url,
      ingredients: recipe.ingredients,
      steps: recipe.steps,
    ));
    final pendingDB = await Hive.openBox<PendingModel>('pending_db');
    final index =
        pendingDB.values.toList().indexWhere((r) => r.title == recipe.title);
    if (index != -1) {
      await pendingDB.deleteAt(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Box<PendingModel>>(
        valueListenable: Hive.box<PendingModel>('pending_db').listenable(),
        builder: (context, box, _) {
          final pendingRecipes = box.values.toList().cast<PendingModel>();

          if (pendingRecipes.isEmpty) {
            return const Center(
              child: Text(
                'No pending recipes available.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: pendingRecipes.length,
            itemBuilder: (BuildContext context, int index) {
              final recipe = pendingRecipes[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text((index + 1).toString()),
                ),
                title: Text(recipe.title),
                subtitle: Text(recipe.category),
                trailing: PopupMenuButton<String>(
                  icon: const Icon(Icons.menu),
                  onSelected: (String value) {
                    if (value == 'accept') {
                      _handleAccept(recipe);
                    } else if (value == 'reject') {
                      _handleReject(recipe);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return ['Accept', 'Reject'].map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice.toLowerCase(),
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
                onTap: () {
                  // Handle onTap action
                },
              );
            },
          );
        },
      ),
    );
  }
}
