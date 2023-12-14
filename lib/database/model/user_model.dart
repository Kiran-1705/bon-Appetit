import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String phone;
  @HiveField(3)
  final String password;
  @HiveField(4)
  String? imagePath;
  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.imagePath,
  });
}
