import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:flutter/material.dart';

class AcceptedRecipes extends StatefulWidget {
  final List<AcceptModel> acceptedRecipes;

  const AcceptedRecipes({Key? key, required this.acceptedRecipes})
      : super(key: key);

  @override
  State<AcceptedRecipes> createState() => _AcceptedRecipesState();
}

class _AcceptedRecipesState extends State<AcceptedRecipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: widget.acceptedRecipes.length,
            itemBuilder: (BuildContext context, int index) {
              final acceptModel = widget.acceptedRecipes[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text((index + 1).toString()),
                ),
                title: Text(acceptModel.title),
                subtitle: Text(acceptModel.category),
                trailing: PopupMenuButton<String>(
                  onSelected: (String value) {
                    // Handle the option selected from the popup menu
                    if (value == 'Add') {
                      // Add logic here for 'Add'
                    } else if (value == 'Delete') {
                      deleteAccepted(index);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'Add',
                        child: Text('Add'),
                      ),
                      PopupMenuItem<String>(
                        value: 'Delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ),
                onTap: () {
                  // Handle the tap on accepted recipe
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
