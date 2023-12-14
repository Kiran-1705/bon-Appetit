import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:bon_appetit/database/model/pending_model.dart';
import 'package:bon_appetit/database/model/recipe_model.dart';
import 'package:bon_appetit/database/model/reject_model.dart';
import 'package:bon_appetit/database/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<UserModel>> userListNotifier =
    ValueNotifier<List<UserModel>>([]);
ValueNotifier<List<RecipeModel>> recipeListNotifier =
    ValueNotifier<List<RecipeModel>>([]);
ValueNotifier<List<AcceptModel>> acceptListNotifier =
    ValueNotifier<List<AcceptModel>>([]);
ValueNotifier<List<PendingModel>> pendingListNotifier =
    ValueNotifier<List<PendingModel>>([]);
ValueNotifier<List<RejectModel>> rejectListNotifier =
    ValueNotifier<List<RejectModel>>([]);

//user
Future<void> getAllUser() async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  userListNotifier.value = userDB.values.toList();
  userListNotifier.notifyListeners();
}

void addUser(UserModel value) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  await userDB.add(value);
  await getAllUser();
}

void deleteUser(int index) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  if (index >= 0 && index < userDB.length) {
    await userDB.deleteAt(index);
    await getAllUser();
  }
}

Future<bool> checkUserExists(UserModel user) async {
  final users = await Hive.openBox<UserModel>('user_db');
  final userList = users.values.toList();

  bool exists = userList.any((existingUser) =>
      existingUser.email == user.email &&
      existingUser.password == user.password);

  return exists;
}

//recipe
Future<void> getAllRecipe() async {
  final recipeDB = await Hive.openBox<RecipeModel>('recipe_db');
  recipeListNotifier.value = recipeDB.values.toList();
  recipeListNotifier.notifyListeners();
}

void addRecipe(RecipeModel value) async {
  final recipeDB = await Hive.openBox<RecipeModel>('recipe_db');
  await recipeDB.add(value);
  await getAllRecipe();
}

void deleteRecipe(int index) async {
  final recipeDB = await Hive.openBox<RecipeModel>('recipe_db');
  if (index >= 0 && index < recipeDB.length) {
    await recipeDB.deleteAt(index);
    await getAllRecipe();
  }
}

//accept
RecipeModel convertToRecipeModel(AcceptModel acceptModel) {
  return RecipeModel(
    title: acceptModel.title,
    category: acceptModel.category,
    url: acceptModel.url,
    ingredients: acceptModel.ingredients,
    imagePath: acceptModel.imagePath,
    steps: acceptModel.steps,
  );
}

Future<List<RecipeModel>> getAllAccept() async {
  final acceptDB = await Hive.openBox<AcceptModel>('accept_db');
  List<AcceptModel> acceptModels = acceptDB.values.toList();
  List<RecipeModel> acceptedRecipes = acceptModels.map((acceptModel) {
    return convertToRecipeModel(acceptModel);
  }).toList();
  acceptListNotifier.value = acceptModels;
  acceptListNotifier.notifyListeners();
  return acceptedRecipes;
}

void addAccept(AcceptModel value) async {
  final acceptDB = await Hive.openBox<AcceptModel>('accept_db');
  await acceptDB.add(value);
  await getAllAccept();
}

void deleteAccepted(int index) async {
  final acceptDB = await Hive.openBox<AcceptModel>('accept_db');
  if (index >= 0 && index < acceptDB.length) {
    await acceptDB.deleteAt(index);
    await getAllAccept();
  }
}

//pending
void addPending(PendingModel recipe) async {
  final pendingDB = await Hive.openBox<PendingModel>('pending_db');
  await pendingDB.add(recipe);
}

//rejected
void addRejected(RejectModel recipe) async {
  final rejectedDB = await Hive.openBox<RejectModel>('rejected_db');
  await rejectedDB.add(recipe);
}

void deleteRejected(int index) {
  final rejectedDB = Hive.box<RejectModel>('rejected_db');
  final rejectedRecipe = rejectedDB.getAt(index);
  if (rejectedRecipe != null) {
    rejectedDB.deleteAt(index);
  }
}
