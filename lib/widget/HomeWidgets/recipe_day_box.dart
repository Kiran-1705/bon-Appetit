import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> imagePaths;
  final Function onTap;

  const RecipeCard({
    required this.title,
    required this.description,
    required this.imagePaths,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recipe',
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kanit',
                  color: Colors.white,
                ),
              ),
              const Text(
                'Of the day.',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontFamily: 'Kanit',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Kanit',
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontFamily: 'Kanit',
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () => onTap(),
                  child: SizedBox(
                    height: 190,
                    child: CarouselSlider(
                      items: imagePaths
                          .map(
                            (item) => Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  item,
                                  fit: BoxFit.fill,
                                  width: 350,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
