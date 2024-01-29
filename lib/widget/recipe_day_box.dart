import 'dart:io';

import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:bon_appetit/widget/display_accept.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class RecipeOfDay extends StatefulWidget {
  final AcceptModel acceptModel;
  final bool? isSelected;
  const RecipeOfDay({
    required this.acceptModel,
    this.isSelected,
    Key? key,
  }) : super(key: key);
  @override
  State<RecipeOfDay> createState() => _RecipeOfDayState();
}

class _RecipeOfDayState extends State<RecipeOfDay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
            widget.acceptModel.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
              fontFamily: 'Kanit',
            ),
          ),
          Text(
            widget.acceptModel.category,
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenOut(
                      recipe: widget.acceptModel,
                    ),
                  ),
                );
              },
              child: SizedBox(
                height: 190,
                child: CarouselSlider(
                  items: widget.acceptModel.imagePath.map((imagePath) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: FileImage(File(imagePath)),
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
