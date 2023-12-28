import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:bon_appetit/widget/display_accept.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AcceptedRecipes extends StatefulWidget {
  const AcceptedRecipes({Key? key}) : super(key: key);

  @override
  State<AcceptedRecipes> createState() => _AcceptedRecipesState();
}

class _AcceptedRecipesState extends State<AcceptedRecipes> {
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

  Future<void> deleteAccepted(int index) async {
    await acceptedBox?.deleteAt(index);
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
                trailing: PopupMenuButton<String>(
                  onSelected: (String value) {
                    if (value == 'Add') {
                      // Add logic here for 'Add'
                    } else if (value == 'Delete') {
                      deleteAccepted(index);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Add',
                        child: Text(
                          'Add',
                          style: TextStyle(fontFamily: 'Kanit', fontSize: 15),
                        ),
                      ),
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
