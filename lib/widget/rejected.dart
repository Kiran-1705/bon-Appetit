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
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'RalewayVariableFont',
                ),
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
                title: Text(
                  recipe.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: 'Kanit',
                  ),
                ),
                subtitle: Text(
                  recipe.category,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Kanit',
                  ),
                ),
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
                        child: Text(
                          'Delete',
                          style: TextStyle(fontFamily: 'Kanit', fontSize: 15),
                        ),
                      ),
                    ];
                  },
                ),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ScreenPendingOut(recipe: recipe),
                  //   ),
                  // );
                },
              );
            },
          );
        },
      ),
    );
  }
}
