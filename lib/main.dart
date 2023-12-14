import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:bon_appetit/database/model/pending_model.dart';
import 'package:bon_appetit/database/model/recipe_model.dart';
import 'package:bon_appetit/database/model/reject_model.dart';
import 'package:bon_appetit/database/model/user_model.dart';
import 'package:bon_appetit/screen/screen_splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const save = 'UserLoggedIN';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId) ||
      !Hive.isAdapterRegistered(RecipeModelAdapter().typeId) ||
      !Hive.isAdapterRegistered(AcceptModelAdapter().typeId) ||
      !Hive.isAdapterRegistered(PendingModelAdapter().typeId) ||
      !Hive.isAdapterRegistered(RejectModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(RecipeModelAdapter());
    Hive.registerAdapter(AcceptModelAdapter());
    Hive.registerAdapter(PendingModelAdapter());
    Hive.registerAdapter(RejectModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bon Appetit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ScreenSplash(),
    );
  }
}
