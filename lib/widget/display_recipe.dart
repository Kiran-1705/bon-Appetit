import 'package:bon_appetit/database/model/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ScreenRecipeOut extends StatefulWidget {
  final RecipeModel recipe;

  const ScreenRecipeOut({Key? key, required this.recipe}) : super(key: key);

  @override
  State<ScreenRecipeOut> createState() => _ScreenRecipeOutState();
}

class _ScreenRecipeOutState extends State<ScreenRecipeOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipe.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
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
            const SizedBox(height: 10),
            _buildIngredientsList(widget.recipe.ingredients),
            const SizedBox(height: 10),
            _buildStepByStepProcess(widget.recipe.steps),
            const SizedBox(height: 10),
            const Column(
              children: [
                Text(
                  'E n j o y  y o u r  m e a l.',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
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
            const Text(
              'Ingredients.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
                color: Colors.white,
              ),
            ),
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
                    style: const TextStyle(color: Colors.white),
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
              const Text(
                'Step-by-step process',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
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
                      style: const TextStyle(color: Colors.white),
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
}
