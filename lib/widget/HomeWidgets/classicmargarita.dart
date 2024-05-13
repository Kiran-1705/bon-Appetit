import 'package:bon_appetit/widget/Components/tab_button.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ScreenClassic extends StatefulWidget {
  ScreenClassic({super.key});

  @override
  State<ScreenClassic> createState() => _ScreenCBState();
}

class _ScreenCBState extends State<ScreenClassic> {
  final String videoUrl = 'XhXgmkP1r3c';
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
  '1.5 oz (45 ml) Blanco tequila',
  '1 oz (30 ml) Cointreau or other orange liqueur',
  '1 oz (30 ml) freshly squeezed lime juice',
  'Lime wedge, for garnish',
  'Coarse salt, for rim (optional)'
];

final List<String> _stepByStepList = [
  'If using salt for the rim, rub the rim of a margarita glass with a lime wedge and dip it in a plate of coarse salt.',
  'Combine tequila, Cointreau, and lime juice in a shaker filled with ice.',
  'Shake vigorously for about 15 seconds, until well chilled.',
  'Strain into the prepared glass.',
  'Garnish with a lime wedge and serve immediately.'
];
