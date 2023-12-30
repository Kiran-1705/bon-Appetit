import 'package:flutter/material.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({Key? key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'S e a r c h',
          style: TextStyle(fontSize: 25, fontFamily: 'Righteous'),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Search by Ingredient/Name',
                labelStyle: const TextStyle(
                    fontFamily: 'RalewayVariableFont',
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 500,
            width: 350,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildImageWithText(
                      imagePath: "lib/assets/search1.png",
                      text: 'BREAKFAST',
                    ),
                    _buildImageWithText(
                      imagePath: "lib/assets/search2.jpg",
                      text: 'LUNCH',
                    ),
                    _buildImageWithText(
                      imagePath: "lib/assets/search3.png",
                      text: 'DINNER',
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildImageWithText(
                      imagePath: "lib/assets/cocktails.jpg",
                      text: 'COCKTAIL',
                    ),
                    _buildImageWithText(
                      imagePath: "lib/assets/search4.png",
                      text: 'SNACK',
                    ),
                    _buildImageWithText(
                      imagePath: "lib/assets/diserts.jpg",
                      text: 'DESSERT',
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildImageWithText(
                      imagePath: "lib/assets/curry.png",
                      text: 'CURRY',
                    ),
                    _buildImageWithText(
                      imagePath: "lib/assets/salad.png",
                      text: 'SALAD',
                    ),
                    _buildImageWithText(
                      imagePath: "lib/assets/diserts.jpg",
                      text: 'DESSERT',
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWithText({
    required String imagePath,
    required String text,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle onTap action
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        height: 120,
        width: 100,
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontFamily: 'Righteous'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
