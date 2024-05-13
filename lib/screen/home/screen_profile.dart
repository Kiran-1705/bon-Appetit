import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/recipe_model.dart';
import 'package:bon_appetit/database/model/user_model.dart';
import 'package:bon_appetit/screen/home/screen_favorites.dart';
import 'package:bon_appetit/screen/home/screen_home.dart';
import 'package:bon_appetit/screen/home/screen_recipes.dart';
import 'package:bon_appetit/screen/home/screen_settings.dart';
import 'package:bon_appetit/widget/AddRecipeWidgets/add_recipe.dart';
import 'package:bon_appetit/widget/ProfileWidgets/profile_goldbutton.dart';
import 'package:bon_appetit/widget/ProfileWidgets/profile_recipelist.dart';
import 'package:bon_appetit/widget/ProfileWidgets/profile_userdetails.dart';
import 'package:bon_appetit/widget/Components/bottom_bar.dart';
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
    const ScreenProfile()
  ];
  String loggedInUserName = '';
  String loggedInUserEmail = '';
  String loggedInUserPhone = '';
  String loggedInUserImagePath = '';
  int greenDotCount = 0;
  @override
  void initState() {
    super.initState();
    getAllUser();
    getUserDetails();
    getAllRecipe();
    updateGreenDotCount();
  }

  Future<void> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('loggedInUserEmail');

    if (email != null) {
      final userDB = Hive.box<UserModel>('user_db');
      final List<UserModel> userList = userDB.values.toList();
      final loggedInUser = userList.firstWhere((user) => user.email == email,
          orElse: () =>
              UserModel(name: '', email: '', phone: '', password: ''));
      setState(() {
        loggedInUserName = loggedInUser.name;
        loggedInUserEmail = loggedInUser.email;
        loggedInUserPhone = loggedInUser.phone;
        loggedInUserImagePath = loggedInUser.imagePath ?? loggedInUserImagePath;
      });
    }
  }

  Future<void> updateGreenDotCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('loggedInUserEmail');

    if (email != null) {
      final List<RecipeModel> recipes = await getAllRecipe();
      int count = 0;
      for (var recipe in recipes) {
        if (recipe.uploadedBy == email) {
          int status = await checkRecipeStatus(recipe.title);
          if (status == 1) {
            count++;
          }
        }
      }
      setState(() {
        greenDotCount = count;
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => _screens[index]));
              });
            }),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('P r o f i l e',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Righteous')),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ScreenSettings()));
                        },
                        icon: const Icon(Icons.settings,
                            color: Colors.white, size: 33)),
                  ])),
          const SizedBox(height: 30),
          UserProfileWidget(
            name: loggedInUserName,
            email: loggedInUserEmail,
            phone: loggedInUserPhone,
            imagePath: loggedInUserImagePath,
          ),
          const SizedBox(height: 20),
          const JoinGoldButton(),
          const SizedBox(height: 10),
          ProfileRecipeList(
            userEmailAddress: loggedInUserEmail,
            recipeListNotifier: recipeListNotifier,
          ),
          const SizedBox(height: 20),
          if (greenDotCount < 3)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenAddRecipes()));
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Recipe',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RalewayVariableFont',
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          const SizedBox(height: 30),
        ]))));
  }
}
