import 'dart:io';
import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/favorite_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteCard extends StatefulWidget {
  final FavoriteModel favoriteModel;
  const FavoriteCard({
    required this.favoriteModel,
    Key? key,
    required String title,
    required String subtitle,
    required imagePath,
  }) : super(key: key);

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: SizedBox(
                height: 125,
                width: 160,
                child: CarouselSlider(
                  items: widget.favoriteModel.imagePath.map((imagePath) {
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
            const SizedBox(width: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Text(
                        widget.favoriteModel.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            fontFamily: 'Kanit',
                            color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          widget.favoriteModel.tips,
                          style: const TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                int index = Hive.box<FavoriteModel>('favorite_db')
                    .values
                    .toList()
                    .indexWhere((element) =>
                        element.title == widget.favoriteModel.title);
                deleteFromFavorites(index);
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
