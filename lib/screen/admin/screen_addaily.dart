import 'package:bon_appetit/widget/recipe_day.dart';
import 'package:bon_appetit/widget/recommended.dart';
import 'package:bon_appetit/widget/tab_button.dart';
import 'package:flutter/material.dart';

class ScreenAdminDaily extends StatefulWidget {
  const ScreenAdminDaily({Key? key}) : super(key: key);

  @override
  State<ScreenAdminDaily> createState() => _ScreenAdminDailyState();
}

class _ScreenAdminDailyState extends State<ScreenAdminDaily> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Daily',
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
          Row(
            children: [
              TabButtons(
                _selectedTabIndex,
                0,
                'RecipeOfDay',
                (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),
              TabButtons(
                _selectedTabIndex,
                1,
                'Recommended',
                (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: _selectedTabIndex == 0 ? RecipeList() : RecommendedRecipe(),
          ),
        ],
      ),
    );
  }
}
