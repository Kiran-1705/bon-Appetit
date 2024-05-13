import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/accept_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bon_appetit/database/model/recipe_model.dart';
import 'package:bon_appetit/widget/AddRecipeWidgets/dynamic_list.dart';
import 'package:bon_appetit/widget/AddRecipeWidgets/image_picker.dart';

class UpdateRecipe extends StatefulWidget {
  final RecipeModel recipe;

  final int index;
  const UpdateRecipe({
    super.key,
    required this.recipe,
    required this.index,
  });

  @override
  State<UpdateRecipe> createState() => _UpdateRecipeState();
}

class _UpdateRecipeState extends State<UpdateRecipe> {
  late TextEditingController _titleController;
  late TextEditingController _ingredientsController;
  late TextEditingController _stepsController;
  late TextEditingController _videoUrlController;
  late TextEditingController _tipsController;

  late List<String> _ingredients;
  late List<String> _steps;
  List<XFile> _selectedImages = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe.title);
    _ingredientsController = TextEditingController();
    _stepsController = TextEditingController();
    _videoUrlController = TextEditingController(text: widget.recipe.url);
    _tipsController = TextEditingController(text: widget.recipe.tips);

    _ingredients = widget.recipe.ingredients.split('\n');
    _steps = widget.recipe.steps.split('\n');
    _selectedCategory = widget.recipe.category;
    _selectedImages =
        widget.recipe.imagePath.map((path) => XFile(path)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Recipe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => updateRecipe(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Choose Category',
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
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            DynamicListWidget(
              items: _ingredients,
              controller: _ingredientsController,
              hintText: "Add Ingredient",
              label: "Ingredients",
              onItemAdded: (item) {
                setState(() {
                  _ingredients.add(item);
                });
              },
              onItemRemoved: (idx) {
                setState(() {
                  _ingredients.removeAt(idx);
                });
              },
            ),
            const SizedBox(height: 10),
            DynamicListWidget(
              items: _steps,
              controller: _stepsController,
              hintText: "Add Step",
              label: "Steps",
              onItemAdded: (item) {
                setState(() {
                  _steps.add(item);
                });
              },
              onItemRemoved: (idx) {
                setState(() {
                  _steps.removeAt(idx);
                });
              },
            ),
            const SizedBox(height: 10),
            ImagePickerWidget(
              selectedImages:
                  _selectedImages.map((xFile) => xFile.path).toList(),
              onImagesSelected: (List<String> paths) {
                setState(() {
                  _selectedImages = paths.map((path) => XFile(path)).toList();
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _videoUrlController,
              decoration: InputDecoration(
                labelText: 'Video URL',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _tipsController,
              decoration: InputDecoration(
                labelText: 'Tips',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateRecipe() async {
    final Box<RecipeModel> recipeDB =
        await Hive.openBox<RecipeModel>('recipe_db');
    final Box<AcceptModel> acceptDB =
        await Hive.openBox<AcceptModel>('accept_db');

    RecipeModel updatedRecipe = RecipeModel(
      category: _selectedCategory!,
      title: widget.recipe.title,
      url: _videoUrlController.text,
      ingredients: _ingredients.join('\n'),
      steps: _steps.join('\n'),
      imagePath: _selectedImages.map((image) => image.path).toList(),
      tips: _tipsController.text,
      uploadedBy: widget.recipe.uploadedBy,
    );

    int acceptIndex = -1;
    for (int i = 0; i < acceptDB.length; i++) {
      if (acceptDB.getAt(i)?.title == widget.recipe.title) {
        acceptIndex = i;
        break;
      }
    }

    AcceptModel editAccepted = AcceptModel(
      category: _selectedCategory!,
      title: widget.recipe.title,
      url: _videoUrlController.text,
      ingredients: _ingredients.join('\n'),
      steps: _steps.join('\n'),
      imagePath: _selectedImages.map((image) => image.path).toList(),
      tips: _tipsController.text,
      uploadedBy: widget.recipe.uploadedBy,
    );

    try {
      await recipeDB.putAt(widget.index, updatedRecipe);
      if (acceptIndex != -1) {
        await acceptDB.putAt(acceptIndex, editAccepted);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Recipe updated successfully"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Could not recipe"),
        ));
        return;
      }
    } catch (e) {
      print('Error updating recipe: $e');
    } finally {
      recipeDB.close();
      acceptDB.close();
    }

    Navigator.pop(context);
  }
}
