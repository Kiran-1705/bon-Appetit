import 'package:hive_flutter/hive_flutter.dart';
part 'reject_model.g.dart';

@HiveType(typeId: 5)
class RejectModel {
  @HiveField(0)
  final String category;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final List<String> imagePath;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final String ingredients;
  @HiveField(5)
  final String steps;
  @HiveField(6)
  final String tips;
  RejectModel(
      {required this.category,
      required this.title,
      required this.imagePath,
      required this.url,
      required this.ingredients,
      required this.steps,
      required this.tips});
}
