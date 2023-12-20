import 'dart:io';
import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/pending_model.dart';
import 'package:bon_appetit/database/model/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

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
  final TextEditingController _videoUrlController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    openRecipeBox();
    getAllRecipe();
  }

  Future<Box<RecipeModel>> openRecipeBox() async {
    final recipeDB = await Hive.openBox<RecipeModel>('recipe_db');
    return recipeDB;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Recipe',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: ['Breakfast', 'Lunch', 'Snack', 'Dinner']
                      .map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorText: _isTitleValid ? null : 'Invalid title format',
                  ),
                ),
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
                                  BorderRadius.all(Radius.circular(5))),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                            ),
                            itemCount: _selectedImages.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Image.file(
                                File(_selectedImages[index].path),
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
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
                                  content:
                                      Text('Please select at least 3 images'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: const Text('Choose Image'),
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
                    labelText: 'Add VideoURL',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorText:
                        _isVideoUrlValid ? null : 'Enter a valid URL format',
                  ),
                ),
                //add ingredients
                const SizedBox(height: 10),
                TextFormField(
                  controller: _ingredientsController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    labelText: 'Add Ingredients',
                    hintText: '1. Ingredient 1\n2. Ingredient 2\n...',
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
                    hintText: '1. Step 1\n2. Step 2\n...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                //add tips
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Add Discription',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_selectedImages.length < 3) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select at least 3 images'),
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
                      );
                      addPending(pendingrecipe);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Data submitted successfully!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      _formKey.currentState!.reset();
                      _selectedImages.clear();
                      setState(() {
                        _isTitleValid = true;
                        _selectedCategory = null;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all fields correctly.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
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
        RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value);
  }

  bool _validateVideoUrl(String value) {
    // return Uri.parse(value).isAbsolute;
    return true;
  }

  bool _validateIngredients(String value) {
    return value.isNotEmpty;
  }

  bool _validateSteps(String value) {
    return value.isNotEmpty;
  }
}
