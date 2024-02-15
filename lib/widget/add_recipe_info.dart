import 'package:flutter/material.dart';

class AddRecipeInfo extends StatelessWidget {
  const AddRecipeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Instructions',
          style: TextStyle(fontSize: 25, fontFamily: 'Righteous'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Category',
                  style: TextStyle(fontSize: 22, fontFamily: 'Righteous')),
              Text('venue of the day where Recipe is best to serve.',
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'Kanit', color: Colors.black)),
              SizedBox(height: 10),
              Text('Title',
                  style: TextStyle(fontSize: 22, fontFamily: 'Righteous')),
              Text('Name of the Dish/Recipe.',
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'Kanit', color: Colors.black)),
              SizedBox(height: 10),
              Text('Adding Images',
                  style: TextStyle(fontSize: 22, fontFamily: 'Righteous')),
              Text('You can add atmost of 6 and atleast 3 images of your dish.',
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'Kanit', color: Colors.black)),
              SizedBox(height: 10),
              Text('Add youtube video URL',
                  style: TextStyle(fontSize: 22, fontFamily: 'Righteous')),
              Text(
                  "Actually we doesn't need the whole URL of the video,we just require the ID of that particular youtube video\nFor Example)This is a URL of a youtube video -'https://youtu.be/8ZzxgIQsyEk?si=TGGfLsxRl5bsIMkD',\nIn this we only need this part of the URL-'8ZzxgIQsyEk'",
                  style: TextStyle(
                      fontSize: 15, fontFamily: 'Kanit', color: Colors.black)),
              SizedBox(height: 10),
              Text('Ingredients',
                  style: TextStyle(fontSize: 22, fontFamily: 'Righteous')),
              Text(
                  'In this case,each line is consider as ingredient.So try to avoid indexing',
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'Kanit', color: Colors.black)),
              SizedBox(height: 10),
              Text('Steps',
                  style: TextStyle(fontSize: 22, fontFamily: 'Righteous')),
              Text(
                  'This case is similar to ingredients.After entering a step,the next line is consider as the next step.So avoid indexing in this case also.',
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'Kanit', color: Colors.black)),
              SizedBox(height: 10),
              Text('Discription',
                  style: TextStyle(fontSize: 22, fontFamily: 'Righteous')),
              Text('A short discription of the dish/recipe',
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'Kanit', color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }
}
