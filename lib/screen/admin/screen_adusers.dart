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
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w700,
            fontFamily: 'RalewayVariableFont',
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: userListNotifier,
              builder:
                  (BuildContext ctx, List<UserModel> userList, Widget? child) {
                if (userList.isEmpty) {
                  return Center(
                    child: Text(
                      'No users yet.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'RalewayVariableFont',
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  itemBuilder: (context, index) {
                    final data = userList[index];
                    return ListTile(
                      trailing: IconButton(
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, index);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      title: Text(
                        data.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      subtitle: Text(
                        data.email,
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Kanit',
                        ),
                      ),
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
          title: const Text(
            "Confirm Delete",
            style: TextStyle(
              fontSize: 23,
              fontFamily: 'RalewayVariableFont',
              fontWeight: FontWeight.w700,
            ),
          ),
          content: const Text(
            "Are you sure you want to delete this user?",
            style: TextStyle(
              fontSize: 17,
              fontFamily: 'RalewayVariableFont',
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text("Cancel",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  )),
            ),
            TextButton(
              onPressed: () {
                deleteUser(index);
                Navigator.of(dialogContext).pop();
              },
              child: const Text("Delete",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  )),
            ),
          ],
        );
      },
    );
  }
}
