import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final List<String> selectedImages;
  final Function(List<String>) onImagesSelected;

  const ImagePickerWidget({
    Key? key,
    required this.selectedImages,
    required this.onImagesSelected,
  }) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage(
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 80,
    );
    if (images != null && images.isNotEmpty) {
      widget.onImagesSelected(images.map((file) => file.path).toList());
      if (widget.selectedImages.length < 3) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: widget.selectedImages.isEmpty
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
                      itemCount: widget.selectedImages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.file(
                              File(widget.selectedImages[index]),
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline,
                                  color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  widget.selectedImages.removeAt(index);
                                });
                              },
                            ),
                          ],
                        );
                      }),
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
              onPressed: _pickImages,
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
    );
  }
}
