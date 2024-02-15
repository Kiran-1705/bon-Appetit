import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class RecommendedBox extends StatelessWidget {
  final String title;
  final String description;
  final List<String> imagePaths;
  final VoidCallback onTap;

  const RecommendedBox({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePaths,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 380,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 20),
                child: SizedBox(
                  height: 220,
                  width: 325,
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
              const SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Kanit',
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontFamily: 'Kanit',
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
