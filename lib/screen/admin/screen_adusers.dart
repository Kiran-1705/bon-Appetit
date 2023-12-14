import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/user_model.dart';
import 'package:flutter/material.dart';

class ScreenAdminUsers extends StatefulWidget {
  const ScreenAdminUsers({Key? key});

  @override
  State<ScreenAdminUsers> createState() => _ScreenAdminUsersState();
}

class _ScreenAdminUsersState extends State<ScreenAdminUsers> {
  @override
  Widget build(BuildContext context) {
    getAllUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'U S E R S',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: userListNotifier,
              builder:
                  (BuildContext ctx, List<UserModel> userList, Widget? child) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final data = userList[index];
                    return ListTile(
                      trailing: IconButton(
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, index);
                          },
                          icon: const Icon(Icons.delete)),
                      title: Text(data.name),
                      subtitle: Text(data.email),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: userList.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this user?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                deleteUser(index);
                Navigator.of(dialogContext).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
