import 'package:flutter/material.dart';
import 'package:bon_appetit/database/model/recipe_model.dart';

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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _updatedFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                // value: _selectedCategory,
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
                    // _selectedCategory = newValue;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _updateTitleController,
                decoration: InputDecoration(
                  hintText: _titleController.text,
                  hintStyle: const TextStyle(
                      fontFamily: 'RalewayVariableFont',
                      fontWeight: FontWeight.w700),
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
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 220,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        // child: GridView.builder(
                        //   gridDelegate:
                        //       const SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 3,
                        //     mainAxisSpacing: 4.0,
                        //     crossAxisSpacing: 4.0,
                        //   ),
                        //   itemCount: _selectedImages.length,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return Image.file(
                        //       File(_selectedImages[index].path),
                        //       fit: BoxFit.cover,
                        //     );
                        //   },
                        // ),
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
                        onPressed: () async {},
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
              TextFormField(
                controller: _updatedVideoUrlController,
                decoration: InputDecoration(
                  hintText: widget.recipe.url,
                  hintStyle: const TextStyle(
                      fontFamily: 'RalewayVariableFont',
                      fontWeight: FontWeight.w700),
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
                controller: _updatedIngredientsController,
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
                controller: _updatedStepsController,
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
                // controller: _updatedTipsController,
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
                  onPressed: () {},
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
}
