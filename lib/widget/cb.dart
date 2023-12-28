import 'package:bon_appetit/widget/tab_button.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ScreenCB extends StatefulWidget {
  ScreenCB({super.key});

  @override
  State<ScreenCB> createState() => _ScreenCBState();
}

class _ScreenCBState extends State<ScreenCB> {
  final String videoUrl = '95BCU1n268w';
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chicken Briyani'),
      ),
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
                  onReady: () {
                    // Add callback logic here if needed
                  },
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
  // _buildIngredientsList(),
  // const SizedBox(height: 10),
  // _buildStepByStepProcess(),
  // const SizedBox(height: 10),
  // const Text(
  //   'Enjoy your meal',
  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  // ),
  // const SizedBox(height: 10),
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
          // const Text(
          //   'Ingredients.',
          //   style: TextStyle(
          //       fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          // ),
          // const SizedBox(height: 10),
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
                    style: const TextStyle(color: Colors.white),
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
          // const Text(
          //   'Step-by-step process',
          //   style: TextStyle(
          //       fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          // ),
          // const SizedBox(height: 5),
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
                    style: const TextStyle(color: Colors.white),
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
  '2 cups Basmati Rice',
  '1 bay leaf',
  '2 cloves',
  '3 cardamom pods',
  '1 cinnamon stick',
  '1 inch ginger, sliced',
  '2 cloves garlic, minced',
  '1 tsp salt',
  '4 cups water',
  '1 tbsp sweet tamarind chutney',
  '1/2 cup ghee or vegetable oil',
  'For the Chicken:',
  '1 kg boneless, skinless chicken thighs, cut into bite-sized pieces',
  '1/2 cup yogurt',
  '1 tbsp lemon juice',
  '1 ginger garlic paste',
  '1 green chili, chopped',
  '1 tbsp coriander powder',
  '1 tsp garam masala',
  '1/2 tsp turmeric powder',
  '1/2 tsp red chili powder',
  'Salt to taste',
  'Oil for cooking',
  'For the Masala:',
  '2 onions, thinly sliced',
  '3 tbsp chopped mint leaves',
  '2 tbsp chopped coriander leaves',
  '1/2 cup saffron milk (soak a few saffron strands in warm milk)',
  '1/4 cup fried onions (birista)',
  'Salt to taste'
];

final List<String> _stepByStepList = [
  'Step 1: Marinate the Chicken:',
  'In a large bowl, combine yogurt, lemon juice, ginger garlic paste, green chili, coriander powder, garam masala, turmeric powder, red chili powder, and salt.',
  'Add the chicken pieces and mix well to coat them evenly.',
  'Cover the bowl and marinate the chicken for at least 30 minutes, or up to 4 hours for deeper flavors.',
  'Step 2: Cook the Rice:',
  'Rinse the basmati rice thoroughly under running water until the water runs clear.',
  'In a large pot, heat ghee or oil over medium heat. Add bay leaf, cloves, cardamom pods, cinnamon stick, ginger, and garlic. Saute for a minute until fragrant.',
  'Add the rinsed rice and salt. Stir fry for 2 minutes to coat the rice with the oil and spices.',
  'Add water and bring to a boil. Once boiling, reduce heat to low, cover the pot, and simmer for 15-20 minutes, or until the rice is cooked and fluffy.',
  'Fluff the rice with a fork and keep it aside.',
  'Step 3: Cook the Chicken:',
  'Heat oil in a large pan or wok over medium heat. Add the marinated chicken and cook for 5-7 minutes, stirring occasionally, until the chicken is browned and cooked through',
  'Add the sliced onions and cook for another 5-7 minutes, until the onions are softened and translucent.',
  'Add the cooked rice, mint leaves, coriander leaves, saffron milk, fried onions, and salt to taste.',
  'Mix everything gently to combine without breaking the rice grains.',
  'Cover the pan and cook on low heat for 5-10 minutes, or until the flavors have infused and the rice is heated through.'
];
