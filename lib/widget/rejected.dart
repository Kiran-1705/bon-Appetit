import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bon_appetit/database/model/reject_model.dart';

class ScreenRejectedRecipes extends StatefulWidget {
  const ScreenRejectedRecipes({Key? key}) : super(key: key);

  @override
  State<ScreenRejectedRecipes> createState() => _ScreenRejectedRecipesState();
}

class _ScreenRejectedRecipesState extends State<ScreenRejectedRecipes> {
  Box<RejectModel>? rejectedBox;

  @override
  void initState() {
    super.initState();
    openRejectedBox();
  }

  Future<void> openRejectedBox() async {
    rejectedBox = await Hive.openBox<RejectModel>('rejected_db');
    setState(() {});
  }

  void deleteRejected(int index) {
    rejectedBox?.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    if (rejectedBox == null || !rejectedBox!.isOpen) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: ValueListenableBuilder<Box<RejectModel>>(
        valueListenable: rejectedBox!.listenable(),
        builder: (context, box, _) {
          final rejectedRecipes = box.values.toList().cast<RejectModel>();

          if (rejectedRecipes.isEmpty) {
            return const Center(
              child: Text(
                'No rejected recipes available.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: rejectedRecipes.length,
            itemBuilder: (BuildContext context, int index) {
              final recipe = rejectedRecipes[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text((index + 1).toString()),
                ),
                title: Text(recipe.title),
                subtitle: Text(recipe.category),
                trailing: PopupMenuButton<String>(
                  onSelected: (String value) {
                    if (value == 'Delete') {
                      deleteRejected(index);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ),
                onTap: () {
                  // Handle onTap action for rejected recipe
                },
              );
            },
          );
        },
      ),
    );
  }
}
