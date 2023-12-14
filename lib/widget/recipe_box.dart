import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class RecipeItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> imagePaths;

  const RecipeItem({
    required this.title,
    required this.subtitle,
    required this.imagePaths,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 245,
      width: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 110,
            width: 150,
            child: CarouselSlider(
              items: imagePaths
                  .map(
                    (item) => Center(
                      child: Image.asset(
                        item,
                        fit: BoxFit.fill,
                        width: 350,
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
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Text(
              subtitle,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const CircleAvatar(
                  minRadius: 18,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  size: 36,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  size: 36,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
