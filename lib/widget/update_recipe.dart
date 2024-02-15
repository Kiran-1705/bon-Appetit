import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bon_appetit/database/model/recipe_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UpdateRecipe extends StatefulWidget {
  final RecipeModel recipe;

  const UpdateRecipe({Key? key, required this.recipe}) : super(key: key);

  @override
  State<UpdateRecipe> createState() => _UpdateRecipeState();
}

class _UpdateRecipeState extends State<UpdateRecipe> {
  late TextEditingController _titleController;
  late TextEditingController _videoUrlController;
  late TextEditingController _ingredientsController;
  late TextEditingController _stepsController;
  late TextEditingController _tipsController;
  late String _selectedCategory;
  List<String>? _selectedImages;
  final GlobalKey<FormState> _updatedFormKey = GlobalKey<FormState>();
  final TextEditingController _updateTitleController = TextEditingController();
  final TextEditingController _updatedVideoUrlController =
      TextEditingController();
  final TextEditingController _updatedIngredientsController =
      TextEditingController();
  final TextEditingController _updatedStepsController = TextEditingController();
  final TextEditingController _updatedTipsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe.title);
    _ingredientsController =
        TextEditingController(text: widget.recipe.ingredients);
    _stepsController = TextEditingController(text: widget.recipe.steps);
    _tipsController = TextEditingController(text: widget.recipe.tips);
    _videoUrlController = TextEditingController(text: widget.recipe.url);
    _selectedCategory = widget.recipe.category;
    _selectedImages = widget.recipe.imagePath;
  }

  Future<void> _pickImages() async {
    List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages?.addAll(pickedFiles.map((file) => file.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Recipe',
          style: TextStyle(fontSize: 25, fontFamily: 'Righteous'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _updatedFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    _selectedCategory = newValue ?? '';
                  });
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: const TextStyle(
                      fontFamily: 'RalewayVariableFont',
                      fontWeight: FontWeight.w700),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 290,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 220,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: _selectedImages!.isNotEmpty
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 4.0,
                                  crossAxisSpacing: 4.0,
                                ),
                                itemCount: _selectedImages!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Image.file(
                                    File(_selectedImages![index]),
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : const Center(
                                child: Text(
                                  'Select at least 3 images',
                                  style: TextStyle(
                                    fontFamily: 'RalewayVariableFont',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                      ),
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
                          await _pickImages();
                        },
                        child: const Text(
                          'Choose Image',
                          style: TextStyle(
                            fontSize: 23,
                            fontFamily: 'RalewayVariableFont',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _videoUrlController,
                onChanged: (value) {
                  setState(() {
                    _videoUrlController.text = _updatedVideoUrlController.text;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Add VideoURL',
                  labelStyle: const TextStyle(
                      fontFamily: 'RalewayVariableFont',
                      fontWeight: FontWeight.w700),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _ingredientsController,
                onChanged: (value) {
                  setState(() {
                    _updatedIngredientsController.text = value;
                  });
                },
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: widget.recipe.ingredients,
                  hintStyle: const TextStyle(
                      fontFamily: 'RalewayVariableFont',
                      fontWeight: FontWeight.w700),
                  labelText: 'Add Ingredients',
                  labelStyle: const TextStyle(
                      fontFamily: 'RalewayVariableFont',
                      fontWeight: FontWeight.w700),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLines: 6,
                controller: _stepsController,
                onChanged: (value) {
                  setState(() {
                    _stepsController.text = _updatedStepsController.text;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Add Steps',
                  labelStyle: const TextStyle(
                    fontFamily: 'RalewayVariableFont',
                    fontWeight: FontWeight.w700,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tipsController,
                onChanged: (value) {
                  setState(() {
                    _tipsController.text = _updatedTipsController.text;
                  });
                },
                decoration: InputDecoration(
                  hintText: widget.recipe.tips,
                  labelText: 'Add Discription',
                  labelStyle: const TextStyle(
                      fontFamily: 'RalewayVariableFont',
                      fontWeight: FontWeight.w700),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    _updateRecipe();
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'RalewayVariableFont',
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateRecipe() {
    RecipeModel updatedRecipe = RecipeModel(
      title: _titleController.text,
      ingredients: _updatedIngredientsController.text,
      steps: _stepsController.text,
      tips: _tipsController.text,
      url: _updatedVideoUrlController.text,
      category: _selectedCategory,
      imagePath: _selectedImages ?? [],
      uploadedBy: '',
    );
    final recipeDB = Hive.box<RecipeModel>('recipe_db');
    final List<RecipeModel> recipeList = recipeDB.values.toList();

    int recipeIndex = recipeList.indexOf(widget.recipe);
    recipeList[recipeIndex] = updatedRecipe;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Recipe Updated successfully',
        style: TextStyle(fontFamily: 'Kanit', fontSize: 15),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
  }
}
