import 'dart:io';
import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/pending_model.dart';
import 'package:bon_appetit/database/model/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenAddRecipes extends StatefulWidget {
  const ScreenAddRecipes({Key? key}) : super(key: key);

  @override
  State<ScreenAddRecipes> createState() => _ScreenAddRecipesState();
}

class _ScreenAddRecipesState extends State<ScreenAddRecipes> {
  String? _selectedCategory;
  bool _isTitleValid = true;
  List<XFile> _selectedImages = <XFile>[];
  bool _isVideoUrlValid = true;
  String? loggedInUserEmail;
  bool _isTipsValid = true;
  final TextEditingController _videoUrlController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _tipsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    openRecipeBox();
    getAllRecipe();
    getUserEmail();
  }

  Future<Box<RecipeModel>> openRecipeBox() async {
    final recipeDB = await Hive.openBox<RecipeModel>('recipe_db');
    return recipeDB;
  }

  Future<void> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedInUserEmail = prefs.getString('loggedInUserEmail');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Recipe',
          style: TextStyle(fontSize: 25, fontFamily: 'Righteous'),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.info, size: 30))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Choose Category',
                    labelStyle: const TextStyle(
                        fontFamily: 'RalewayVariableFont',
                        fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: [
                    'Breakfast',
                    'Lunch',
                    'Snack',
                    'Dinner',
                    'Cocktail',
                    'Dessert ',
                    'Curry',
                    'Soup',
                    'Salad',
                    'Cake'
                  ].map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: const TextStyle(
                            fontFamily: 'RalewayVariableFont',
                            fontWeight: FontWeight.w700),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                ),
                const SizedBox(height: 10),
                //title
                TextFormField(
                    controller: _titleController,
                    onChanged: (value) {
                      setState(() {
                        _isTitleValid = _validateTitle(value);
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: const TextStyle(
                            fontFamily: 'RalewayVariableFont',
                            fontWeight: FontWeight.w700),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        errorText: _isTitleValid ? null : 'Invalid title',
                        errorStyle: const TextStyle(
                            fontFamily: 'RalewayVariableFont',
                            fontWeight: FontWeight.w700))),
                const SizedBox(height: 10),
                Container(
                  height: 290,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                            height: 220,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: _selectedImages.isEmpty
                                ? const Center(
                                    child: Text('Select at least 3 images',
                                        style: TextStyle(
                                            fontFamily: 'RalewayVariableFont',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16)))
                                : GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 4.0,
                                      crossAxisSpacing: 4.0,
                                    ),
                                    itemCount: _selectedImages.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Image.file(
                                          File(_selectedImages[index].path),
                                          fit: BoxFit.cover);
                                    })),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            final picker = ImagePicker();
                            List<XFile>? images = await picker.pickMultiImage(
                              maxWidth: 300,
                              maxHeight: 300,
                              imageQuality: 80,
                            );

                            setState(() {
                              _selectedImages = images;
                            });

                            if (_selectedImages.length < 3) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please select at least 3 images',
                                    style: TextStyle(
                                        fontFamily: 'RalewayVariableFont',
                                        fontWeight: FontWeight.w700),
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Choose Image',
                            style: TextStyle(
                                fontSize: 23,
                                fontFamily: 'RalewayVariableFont',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //videoURL
                const SizedBox(height: 10),
                TextFormField(
                  controller: _videoUrlController,
                  onChanged: (value) {
                    setState(() {
                      _isVideoUrlValid = _validateVideoUrl(value);
                    });
                  },
                  decoration: InputDecoration(
                    helperText:
                        'Only *W4e0r4m-1GY* part of URL is required of \nhttps://youtu.be/W4e0r4m-1GY?si=M6x8C4P2o3rVJLa6',
                    helperStyle: const TextStyle(
                        fontFamily: 'RalewayVariableFont',
                        fontWeight: FontWeight.w700),
                    labelText: 'Add VideoURL',
                    labelStyle: const TextStyle(
                        fontFamily: 'RalewayVariableFont',
                        fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorText:
                        _isVideoUrlValid ? null : 'Enter a valid URL format',
                    errorStyle: const TextStyle(
                        fontFamily: 'RalewayVariableFont',
                        fontWeight: FontWeight.w700),
                  ),
                ),
                //add ingredients
                const SizedBox(height: 10),
                TextFormField(
                  controller: _ingredientsController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    labelText: 'Add Ingredients',
                    labelStyle: const TextStyle(
                        fontFamily: 'RalewayVariableFont',
                        fontWeight: FontWeight.w700),
                    hintText: '1. Ingredient 1\n2. Ingredient 2\n...',
                    hintStyle: const TextStyle(
                        fontFamily: 'RalewayVariableFont',
                        fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                //add steps
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 6,
                  controller: _stepsController,
                  decoration: InputDecoration(
                    labelText: 'Add Steps',
                    labelStyle: const TextStyle(
                        fontFamily: 'RalewayVariableFont',
                        fontWeight: FontWeight.w700),
                    hintText: '1. Step 1\n2. Step 2\n...',
                    hintStyle: const TextStyle(
                        fontFamily: 'RalewayVariableFont',
                        fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                //add tips
                const SizedBox(height: 10),
                TextFormField(
                  controller: _tipsController,
                  onChanged: (value) {
                    setState(() {
                      _isTipsValid = _validateTips(value);
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Add Description',
                    labelStyle: const TextStyle(
                      fontFamily: 'RalewayVariableFont',
                      fontWeight: FontWeight.w700,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorText:
                        _isTipsValid ? null : 'Invalid description format',
                    errorStyle: const TextStyle(
                      fontFamily: 'RalewayVariableFont',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Uploaded By $loggedInUserEmail',
                  style: const TextStyle(
                      fontFamily: 'RalewayVariableFont',
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_selectedImages.isEmpty ||
                          _selectedCategory == null ||
                          _titleController.text.isEmpty ||
                          _videoUrlController.text.isEmpty ||
                          _ingredientsController.text.isEmpty ||
                          _stepsController.text.isEmpty ||
                          _tipsController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in all fields.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

                      RecipeModel recipe = RecipeModel(
                        category: _selectedCategory!,
                        title: _titleController.text,
                        url: _videoUrlController.text,
                        ingredients: _ingredientsController.text,
                        steps: _stepsController.text,
                        imagePath:
                            _selectedImages.map((image) => image.path).toList(),
                        tips: _tipsController.text,
                      );
                      addRecipe(recipe);
                      PendingModel pendingrecipe = PendingModel(
                        category: _selectedCategory!,
                        title: _titleController.text,
                        url: _videoUrlController.text,
                        ingredients: _ingredientsController.text,
                        steps: _stepsController.text,
                        imagePath:
                            _selectedImages.map((image) => image.path).toList(),
                        tips: _tipsController.text,
                      );
                      addPending(pendingrecipe);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Recipe submitted successfully',
                            style: TextStyle(fontFamily: 'Kanit', fontSize: 15),
                          ),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      _formKey.currentState!.reset();
                      _selectedImages.clear();
                      _titleController.clear();
                      _videoUrlController.clear();
                      _ingredientsController.clear();
                      _stepsController.clear();
                      setState(() {
                        _isTitleValid = true;
                        _selectedCategory = null;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please fill in all fields correctly.',
                            style: TextStyle(fontFamily: 'Kanit', fontSize: 15),
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'RalewayVariableFont',
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validateTitle(String value) {
    return value.trim().length >= 5 &&
        !value.startsWith(' ') &&
        !value.endsWith(' ') &&
        RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value) &&
        !RegExp(r'[!@#%^&*(),.?":{}|<>]').hasMatch(value);
  }

  bool _validateVideoUrl(String value) {
    // return Uri.parse(value).isAbsolute;
    return true;
  }

  bool _validateTips(String value) {
    return value.trim().isNotEmpty &&
        !RegExp(r'[^a-zA-Z0-9\s.,;:]+').hasMatch(value);
  }

  bool _validateIngredients(String value) {
    return value.isNotEmpty;
  }

  bool _validateSteps(String value) {
    return value.isNotEmpty;
  }
}
