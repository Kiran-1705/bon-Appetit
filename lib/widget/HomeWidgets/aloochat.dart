import 'package:bon_appetit/widget/Components/tab_button.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ScreenAlooChat extends StatefulWidget {
  ScreenAlooChat({Key? key});

  @override
  State<ScreenAlooChat> createState() => _ScreenAlooChatState();
}

class _ScreenAlooChatState extends State<ScreenAlooChat> {
  final String videoUrl = 'hh2rzP9pXU4';

  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Aloo Chat',
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
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
            const Text(
              'Ingredients.',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
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
                          fontFamily: 'Kanit',
                          fontSize: 17,
                          color: Colors.white),
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
            const Text(
              'Step-by-step process',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            const SizedBox(height: 5),
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
                          fontFamily: 'Kanit',
                          fontSize: 17,
                          color: Colors.white),
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
    '250 gms Potato',
    '1/4 tsp black pepper',
    '1/2 tsp red chilli',
    '1/2 tsp roasted cumin powder',
    '1/2 teaspoon dry mango powder (amchur powder)',
    '1/2 teaspoon chaat masala',
    'Black salt/white salt as per taste',
    '1 tbsp finely chopped mint leaves',
    '2 tbsp finely chopped coriander leaves',
    '1 green chilli (finely chopped)',
    '1 tbsp sweet tamarind chutney',
    '1 to 2 tsp lemon juice',
  ];

  final List<String> _stepByStepList = [
    'Peel and dice the potato in small finger-sized pieces.',
    'Fry them under medium-low heat until golden brown.',
    'Toss them in a bowl and add all the ingredients listed above under "For Chaat".',
    'Give the mix a nice stir and serve hot.',
  ];
}
