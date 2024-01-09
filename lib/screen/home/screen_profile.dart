import 'dart:io';
import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/recipe_model.dart';
import 'package:bon_appetit/database/model/user_model.dart';
import 'package:bon_appetit/screen/home/screen_favorites.dart';
import 'package:bon_appetit/screen/home/screen_home.dart';
import 'package:bon_appetit/screen/home/screen_recipes.dart';
import 'package:bon_appetit/screen/home/screen_settings.dart';
import 'package:bon_appetit/widget/add_recipe.dart';
import 'package:bon_appetit/widget/bottom_bar.dart';
import 'package:bon_appetit/widget/display_recipe.dart';
import 'package:bon_appetit/widget/update_recipe.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  int _currentIndex = 3;

  final List<Widget> _screens = [
    const ScreenHome(),
    const ScreenRecipes(),
    const ScreenFavorites(),
    const ScreenProfile(),
  ];
  String loggedInUserName = '';
  String loggedInUserEmail = '';
  String loggedInUserPhone = '';
  String loggedInUserImagePath = '';

  @override
  void initState() {
    super.initState();
    getAllUser();
    getUserDetails();
    getAllRecipe();
  }

  Future<void> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('loggedInUserEmail');

    if (email != null) {
      final userDB = Hive.box<UserModel>('user_db');
      final List<UserModel> userList = userDB.values.toList();

      final loggedInUser = userList.firstWhere(
        (user) => user.email == email,
        orElse: () => UserModel(
          name: '',
          email: '',
          phone: '',
          password: '',
        ),
      );

      setState(() {
        loggedInUserName = loggedInUser.name;
        loggedInUserEmail = loggedInUser.email;
        loggedInUserPhone = loggedInUser.phone;
        loggedInUserImagePath = loggedInUser.imagePath ?? loggedInUserImagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: CurvedNavigationBarWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => _screens[index]),
            );
          });
        },
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'P r o f i l e',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Righteous'),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScreenSettings(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 33,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                      minRadius: 55,
                      backgroundImage: FileImage(File(loggedInUserImagePath))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            loggedInUserName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontFamily: 'Righteous'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        loggedInUserEmail,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Righteous',
                            fontSize: 17),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        loggedInUserPhone,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Righteous',
                            fontSize: 17),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 345,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.workspace_premium, size: 30),
                        SizedBox(width: 20),
                        Text(
                          'Join bon Appetit Gold',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'RalewayVariableFont',
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'My Recipes.',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: ValueListenableBuilder<List<RecipeModel>>(
                        valueListenable: recipeListNotifier,
                        builder: (context, recipes, _) => recipes.isEmpty
                            ? const Center(
                                child: Text(
                                  'No recipes available',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Kanit',
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: recipes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final recipe = recipes[index];
                                  return ListTile(
                                    leading: Stack(
                                      children: [
                                        CircleAvatar(
                                          child: Text((index + 1).toString()),
                                        ),
                                        FutureBuilder<int>(
                                          future:
                                              checkRecipeStatus(recipe.title),
                                          builder: (context, snapshot) {
                                            Color dotColor = Colors.grey;
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              if (snapshot.hasData) {
                                                switch (snapshot.data) {
                                                  case 1:
                                                    dotColor = Colors.green;
                                                    break;
                                                  case 0:
                                                    dotColor = Colors.red;
                                                    break;
                                                  case -1:
                                                    dotColor = Colors.grey;
                                                    break;
                                                  default:
                                                    dotColor = Colors.grey;
                                                }
                                              }
                                            }
                                            return Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                width: 15,
                                                height: 15,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: dotColor,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
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
                                          fontFamily: 'Kanit', fontSize: 15),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ScreenRecipeOut(recipe: recipe),
                                        ),
                                      );
                                    },
                                    trailing: PopupMenuButton<String>(
                                      icon: const Icon(Icons.more_vert),
                                      onSelected: (String value) {
                                        if (value == 'edit') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateRecipe(
                                                      recipe: recipes[index]),
                                            ),
                                          );
                                        } else if (value == 'delete') {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                  'Confirmation',
                                                  style: TextStyle(
                                                      fontFamily: 'Kanit',
                                                      fontSize: 20),
                                                ),
                                                content: const Text(
                                                  'Are you sure you want to delete this recipe?',
                                                  style: TextStyle(
                                                      fontFamily: 'Kanit',
                                                      fontSize: 17),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'No',
                                                      style: TextStyle(
                                                          fontFamily: 'Kanit',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      deleteRecipe(index);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                          fontFamily: 'Kanit',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return ['Edit', 'Delete']
                                            .map((String choice) {
                                          return PopupMenuItem<String>(
                                            value: choice.toLowerCase(),
                                            child: Text(
                                              choice,
                                              style: const TextStyle(
                                                  fontFamily: 'Kanit',
                                                  fontSize: 15),
                                            ),
                                          );
                                        }).toList();
                                      },
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenAddRecipes(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  'Add Recipes',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RalewayVariableFont',
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
