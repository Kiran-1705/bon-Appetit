import 'dart:io';

import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class RecipeItem extends StatefulWidget {
  final AcceptModel acceptModel;
  const RecipeItem({
    required this.acceptModel,
    Key? key,
    required String title,
    required String subtitle,
    required imagePath,
  }) : super(key: key);
  @override
  State<RecipeItem> createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 230,
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
                  items: widget.acceptModel.imagePath.map((imagePath) {
                    return Image(
                      image: FileImage(File(imagePath)),
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                widget.acceptModel.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                widget.acceptModel.category,
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
      ),
    );
  }
}
