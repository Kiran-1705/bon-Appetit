import 'package:bon_appetit/database/model/favorite_model.dart';
import 'package:bon_appetit/widget/tab_button.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ScreenFavoriteOut extends StatefulWidget {
  final FavoriteModel recipe;

  const ScreenFavoriteOut({super.key, required this.recipe});

  @override
  State<ScreenFavoriteOut> createState() => _ScreenFavoriteOutState();
}

class _ScreenFavoriteOutState extends State<ScreenFavoriteOut> {
  int selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipe.title,
          style: const TextStyle(
              fontFamily: 'Kanit', fontWeight: FontWeight.w400, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 250,
                child: YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: widget.recipe.url,
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
                ? _buildIngredientsList(widget.recipe.ingredients)
                : _buildStepByStepProcess(widget.recipe.steps),
            const SizedBox(height: 10),
            const Column(
              children: [
                Text(
                  'E n j o y  y o u r  m e a l.',
                  style: TextStyle(
                      fontFamily: 'Kanit',
                      fontWeight: FontWeight.w400,
                      fontSize: 23),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

Widget _buildIngredientsList(String ingredients) {
  final ingredientsList = ingredients.split('\n');
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: [
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ingredientsList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(
                  Icons.circle,
                  color: Colors.white,
                ),
                title: Text(
                  ingredientsList[index],
                  style: const TextStyle(
                      fontFamily: 'Kanit', fontSize: 17, color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

Widget _buildStepByStepProcess(String steps) {
  final stepByStepList = steps.split('\n');
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stepByStepList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    '${index + 1}.',
                    style: const TextStyle(color: Colors.white),
                  ),
                  title: Text(
                    stepByStepList[index],
                    style: const TextStyle(
                        fontFamily: 'Kanit', fontSize: 17, color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
