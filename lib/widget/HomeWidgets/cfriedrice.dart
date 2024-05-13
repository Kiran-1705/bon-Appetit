import 'package:bon_appetit/widget/Components/tab_button.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ScreenCFriedRice extends StatefulWidget {
  ScreenCFriedRice({super.key});

  @override
  State<ScreenCFriedRice> createState() => _ScreenCBState();
}

class _ScreenCBState extends State<ScreenCFriedRice> {
  final String videoUrl = 'd02B2WIV-uU';
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Classic Margarita',
            style: TextStyle(
                fontFamily: 'Kanit', fontWeight: FontWeight.w400, fontSize: 23),
          ),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 250,
                width: 380,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: videoUrl,
                    flags: const YoutubePlayerFlags(
                      autoPlay: true,
                      mute: true,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                  onReady: () {},
                ),
              ),
            ),
            Row(
              children: [
                TabButtons(
                  selectedTabIndex,
                  0,
                  'Ingredients',
                  (index) {
                    setState(() {
                      selectedTabIndex = index;
                    });
                  },
                ),
                TabButtons(
                  selectedTabIndex,
                  1,
                  'Step by step',
                  (index) {
                    setState(() {
                      selectedTabIndex = index;
                    });
                  },
                ),
              ],
            ),
            selectedTabIndex == 0
                ? _buildIngredientsList()
                : _buildStepByStepProcess(),
            const SizedBox(height: 10),
            const Text(
              'Enjoy your meal',
              style: TextStyle(
                  fontFamily: 'Kanit',
                  fontWeight: FontWeight.w400,
                  fontSize: 23),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

Widget _buildIngredientsList() {
  return Container(
    height: 300,
    width: 380,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _ingredientsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(
                    Icons.circle,
                    color: Colors.white,
                  ),
                  title: Text(
                    _ingredientsList[index],
                    style: const TextStyle(
                        fontFamily: 'Kanit', fontSize: 17, color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStepByStepProcess() {
  return Container(
    height: 300,
    width: 380,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _stepByStepList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    '${index + 1}.',
                    style: const TextStyle(color: Colors.white),
                  ),
                  title: Text(
                    _stepByStepList[index],
                    style: const TextStyle(
                        fontFamily: 'Kanit', fontSize: 17, color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

final List<String> _ingredientsList = [
  'For the Rice:',
  '2 cups cooked white rice (preferably day-old or cooled)',
  '1 tablespoon vegetable oil',
  '2 eggs, beaten',
  '1/4 teaspoon salt',
  'For the Vegetables:',
  '1/2 onion, diced',
  '1 carrot, diced',
  '1/2 cup frozen peas',
  '1/2 bell pepper (any color), diced (optional)',
  'For the Protein:',
  '1/2 pound boneless, skinless chicken breast, cooked and diced',
  'You can also substitute with shrimp, tofu, or other protein of your choice.',
  'For the Seasoning:',
  '2 tablespoons soy sauce',
  '1 tablespoon oyster sauce (optional)',
  '1/2 teaspoon sesame oil',
  '1/4 teaspoon black pepper',
  '1/4 teaspoon garlic powder',
  'Chopped green onions, for garnish (optional)'
];

final List<String> _stepByStepList = [
  'Prepare the Rice: If using fresh rice, cook it according to package instructions and cool it completely.',
  'Heat the Oil: In a large wok or skillet, heat oil over medium-high heat.',
  'Scramble the Eggs: Add the beaten eggs and scramble until cooked through. Set aside.',
  'Cook the Vegetables: Add the onion and carrot to the pan and cook for 2-3 minutes, until softened. Add the peas and bell pepper (if using) and cook for another minute.',
  'Cook the Protein: Add the cooked chicken (or other protein) to the pan and stir-fry for 2-3 minutes, until heated through.',
  'Season and Combine: Add the cooked rice, soy sauce, oyster sauce (if using), sesame oil, black pepper, and garlic powder to the pan. Stir-fry for 2-3 minutes, until everything is heated through and well combined.',
  'Add the Eggs: Add the scrambled eggs back to the pan and mix gently to incorporate them into the rice.',
  'Serve: Garnish with chopped green onions (optional) and serve immediately.'
];
